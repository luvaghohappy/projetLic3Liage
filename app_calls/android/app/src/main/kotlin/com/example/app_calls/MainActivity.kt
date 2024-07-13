package com.example.app_calls

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app_calls/callState"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Cache the FlutterEngine
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "incomingCall" -> result.success("Incoming call received in Flutter")
                "callAnswered" -> result.success("Call answered in Flutter")
                "callEnded" -> result.success("Call ended in Flutter")
                "missedCall" -> result.success("Missed call in Flutter")
                else -> result.notImplemented()
            }
        }
    }
}
