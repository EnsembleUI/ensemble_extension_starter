import 'package:ensemble/ensemble_app.dart';
import 'package:ensemble/framework/error_handling.dart';
import 'package:ensemble/framework/widget/error_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// this demonstrates an App running exclusively with Ensemble
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initErrorHandler();
  runApp(EnsembleApp());
}

void initErrorHandler() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return MaterialApp(home: ErrorScreen(errorDetails));
  };

  /// print errors on console and Chrome dev tool (for Web)
  FlutterError.onError = (details) {
    if (details.exception is EnsembleError) {
      debugPrint(details.exception.toString());
      ErrorWidget.builder(details);
    } else {
      debugPrint(details.exception.toString());
      ErrorWidget.builder(details);
    }
  };

  // async error
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint("Async Error: " + error.toString());
    return true;
  };
}
