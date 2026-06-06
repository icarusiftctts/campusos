package com.example.campusos

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.mediapipe.tasks.genai.llminference.LlmInference
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private val CHANNEL = "gemma_inference"
    private var llmInference: LlmInference? = null
    private val executor = Executors.newSingleThreadExecutor()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initialize" -> {
                    val modelPath = call.argument<String>("modelPath")
                    if (modelPath != null) {
                        executor.execute {
                            try {
                                val options = LlmInference.LlmInferenceOptions.builder()
                                    .setModelPath(modelPath)
                                    .setMaxTokens(2048)
                                    .setTemperature(0.7f)
                                    .build()
                                llmInference = LlmInference.createFromOptions(context, options)
                                runOnUiThread { result.success(null) }
                            } catch (e: Exception) {
                                runOnUiThread { result.error("INIT_FAILED", e.message, null) }
                            }
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "modelPath is null", null)
                    }
                }
                "runInference" -> {
                    val prompt = call.argument<String>("prompt")
                    val inference = llmInference
                    if (prompt != null && inference != null) {
                        executor.execute {
                            try {
                                val response = inference.generateResponse(prompt)
                                runOnUiThread { result.success(response) }
                            } catch (e: Exception) {
                                runOnUiThread { result.error("INFERENCE_FAILED", e.message, null) }
                            }
                        }
                    } else if (inference == null) {
                        result.error("NOT_INITIALIZED", "Model not initialized", null)
                    } else {
                        result.error("INVALID_ARGUMENT", "prompt is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
