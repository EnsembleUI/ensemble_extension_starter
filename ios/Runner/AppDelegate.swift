import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  static let methodChannelName: String = "com.ensembleui.dev/safari-extension"
  static let saveToKeychainMethod: String = "saveToKeychain"
  static let groupId: String = "group.com.example.ensembleExtensionStarter"

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
          if (call.method == AppDelegate.saveToKeychainMethod) {
            guard let args = call.arguments as? [String : Any] else { return }
            print("Arguments: \(args)")
            guard let authTokenVal = args["authToken"] as? String else { return }
            // Store Token into the Keychain
            _ = KeychainService().write(key: args.keys.first ?? "", value: args.values.first as? String ?? "", groupId: AppDelegate.groupId, accountName: nil, synchronizable: false, accessibility: nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
