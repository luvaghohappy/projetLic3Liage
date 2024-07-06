package com.example.calls

import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Bundle
import android.telephony.TelephonyManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.FlutterEngineCache
import java.net.HttpURLConnection
import java.net.URL

class MainActivity : FlutterActivity(), LocationListener {
    private lateinit var locationManager: LocationManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Instantiate a FlutterEngine.
        val flutterEngine = FlutterEngine(this)

        // Start executing Dart code in the FlutterEngine.
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)

        // Register BroadcastReceiver for incoming calls
        val filter = IntentFilter()
        filter.addAction("android.intent.action.PHONE_STATE")
        registerReceiver(callReceiver, filter)

        // Initialize LocationManager
        locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager

        // Check for location permissions
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED &&
            ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION), 1)
            return
        }

        // Request location updates
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0f, this)
    }

    private val callReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == "android.intent.action.PHONE_STATE") {
                val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
                if (state == TelephonyManager.EXTRA_STATE_RINGING) {
                    // An incoming call is received
                    // Fetch the location and send to the backend
                    sendLocationToBackend()
                }
            }
        }
    }

    private fun sendLocationToBackend() {
        val location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
        location?.let {
            val latitude = it.latitude
            val longitude = it.longitude
            val urlString = "https://your-backend-endpoint.com/track?lat=$latitude&lon=$longitude"
            val url = URL(urlString)
            val urlConnection: HttpURLConnection = url.openConnection() as HttpURLConnection
            urlConnection.requestMethod = "GET"
            try {
                val responseCode = urlConnection.responseCode
                if (responseCode == 200) {
                    // Successfully sent location to backend
                }
            } finally {
                urlConnection.disconnect()
            }
        }
    }

    override fun onLocationChanged(location: Location) {
        // Update location if needed
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == 1 && grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            // Permission granted, request location updates
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED ||
                ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0f, this)
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(callReceiver)
    }
}
