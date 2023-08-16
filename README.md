# ensemble_extension_starter

This extension starter project comes with Ensemble App and an iOS Safari Extension.

## Get Started
This EnsembleExtension safari extension will allow.

1. Run the app and install the Ensemble Extension Starter iOS App (develop branch). It uses the ```ensemble/apps/helloApp/SafariExtensionApp2.yaml``` Ensmeble Definition for the root screen.
2. You'll see the home page with two textfields. Now enter the key and value to store it into keychain. Now just minimize the app
3. Open iOS Safari Browser and click AA button in the URL textfield.
4. Click Manage Extension and enable the EnsembleExtension. Also allow permission to use the extension and close the popup
5. Print Token button will print the token inside the SwiftWebExtensionHanlder.swift.

## How it works?
1. From ensemble, store the token using `ensemble.saveToKeychain` method with key and value.
2. This will trigger the method inside the `AppDelegate.swift`'s `saveToKeychain` with the datas (key and value). Then it'll store the token to the Keychain.
3. Now you can access the stored token from App or Extension using the `KeychainService` (This keychain service class has both targets (app and extension), so you can access from the App targets and from Extension targets).
4. Both app and the extension have the same groupId, so the keychain is common for both the app and the extension.
5. In the extension, when we click the print token button it'll send the message using `browser.runtime.sendMessage` with type `tokenExchange`. The background.js will listen for the type with `browser.runtime.onMessage` and it'll call `browser.runtime.sendNativeMessage`, this will invoke the beginRequest method inside the `SafariWebExtensionHandler.swift`