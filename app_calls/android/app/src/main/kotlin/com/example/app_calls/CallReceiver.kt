package com.example.app_calls

import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngineCache
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import java.io.OutputStream
import java.net.HttpURLConnection
import java.net.URL

class CallReceiver : BroadcastReceiver() {
    companion object {
        const val CHANNEL = "com.example.app_calls/callState"
        var lastState: String? = null
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == "android.intent.action.PHONE_STATE") {
            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
            val number = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)

            if (lastState == state) {
                // No change, just ignore
                return
            }

            when (state) {
                TelephonyManager.EXTRA_STATE_RINGING -> {
                    Log.d("CallReceiver", "Incoming call detected")
                    notifyFlutter(context, "incomingCall")
                    getLastLocation(context)
                }
                TelephonyManager.EXTRA_STATE_OFFHOOK -> {
                    Log.d("CallReceiver", "Call answered")
                    notifyFlutter(context, "callAnswered")
                    // Start recording if necessary
                }
                TelephonyManager.EXTRA_STATE_IDLE -> {
                    if (lastState == TelephonyManager.EXTRA_STATE_RINGING) {
                        Log.d("CallReceiver", "Missed call")
                        notifyFlutter(context, "missedCall")
                    } else if (lastState == TelephonyManager.EXTRA_STATE_OFFHOOK) {
                        Log.d("CallReceiver", "Call ended")
                        notifyFlutter(context, "callEnded")
                        // Stop recording if necessary
                    }
                }
            }

            lastState = state
        }
    }

    private fun notifyFlutter(context: Context, method: String) {
        val flutterEngine = FlutterEngineCache.getInstance().get("my_engine_id")
        if (flutterEngine != null) {
            val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            methodChannel.invokeMethod(method, null)
        }
    }

    private fun getLastLocation(context: Context) {
        val fusedLocationClient: FusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(context)
        if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
            fusedLocationClient.lastLocation
                .addOnSuccessListener { location: Location? ->
                    if (location != null) {
                        val latitude = location.latitude
                        val longitude = location.longitude
                        sendLocationToBackend(latitude, longitude)
                    } else {
                        Log.d("CallReceiver", "Location is null")
                    }
                }
                .addOnFailureListener { e ->
                    Log.e("CallReceiver", "Error getting location", e)
                }
        }
    }

    private fun sendLocationToBackend(latitude: Double, longitude: Double) {
        val urlString = "http://192.168.43.148:81/projetSV/calls.php"
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
                Log.e("CallReceiver", "Error sending location to backend", e)
            }
        }.start()
    }
}
