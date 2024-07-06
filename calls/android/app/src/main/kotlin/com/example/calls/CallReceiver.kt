package com.example.calls

import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.app.ActivityCompat
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.FlutterEngineCache
import java.io.OutputStream
import java.net.HttpURLConnection
import java.net.URL

class CallReceiver : BroadcastReceiver() {
    companion object {
        const val CHANNEL = "com.example.calls/callState"
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == "android.intent.action.PHONE_STATE") {
            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
            if (TelephonyManager.EXTRA_STATE_RINGING == state) {
                Log.d("CallReceiver", "Incoming call detected")

                val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
                if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                    val location: Location? = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
                    if (location != null) {
                        val latitude = location.latitude
                        val longitude = location.longitude
                        sendLocationToBackend(latitude, longitude)
                    }
                } else {
                    Log.d("CallReceiver", "Location permission not granted")
                }

                // Notify Flutter about the incoming call
                val flutterEngine = FlutterEngineCache.getInstance().get("my_engine_id")
                if (flutterEngine != null) {
                    val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                    methodChannel.invokeMethod("incomingCall", null)
                }
            }
        }
    }

    private fun sendLocationToBackend(latitude: Double, longitude: Double) {
        val urlString = "http://localhost:81/projetSV/calls.php"
        val data = "latitude=$latitude&longitude=$longitude"

        Thread {
            try {
                val url = URL(urlString)
                val conn = url.openConnection() as HttpURLConnection
                conn.requestMethod = "POST"
                conn.doOutput = true
                val os: OutputStream = conn.outputStream
                os.write(data.toByteArray())
                os.flush()
                os.close()
                val responseCode: Int = conn.responseCode
                Log.d("CallReceiver", "Response code: $responseCode")
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }.start()
    }
}
