import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let safariExtensionChannel = FlutterMethodChannel(name: "com.ensembleui.dev/safari-extension", binaryMessenger: controller.binaryMessenger)
      
      safariExtensionChannel.setMethodCallHandler({
(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // This method is invoked on the UI thread.
        // Handle safariExtensionChannel messages.
          if (call.method == "ensembleExtension") {
              let defaults = UserDefaults(suiteName: "group.com.example.ensembleExtensionStarter")
              let replacementCount = (defaults?.integer(forKey: "WordReplacementCount")) ?? 0
              let replacedLbl = "You've replaced \(replacementCount) words"
              result(replacedLbl)
          } else {
              result(FlutterMethodNotImplemented)
          }
    })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
