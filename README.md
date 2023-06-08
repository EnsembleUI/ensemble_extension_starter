# ensemble_extension_starter

This extension starter project comes with Ensemble App and an iOS Safari Extension.

## Get Started
This EnsembleExtension safari extension will modify the word ```Ensemble``` to ```Ensemble 🛠️👨‍💻``` in any website.

1. Run the app and install the Ensemble Extension Starter iOS App. It uses the ```ensemble/apps/helloApp/SafariExtensionApp.yaml``` Ensmeble Definition for the root screen.
2. You'll see the home page with "You've replaced 0 words". Now just minimize the app
3. Open iOS Safari Browser and click AA button in the URL text field.
4. Click Manage Extension and enable the EnsembleExtension. Also allow permission to use the extension and close the popup
5. Enter ensembleui.com in URL field and see the changes. It converts the word "Ensemble" to "Ensemble 🛠️👨‍💻" in the web page.
6. Open the Ensemble Extension Starter App, click the ```Refresh``` button and then click the ```Get Value``` button. You'll get the number of words replaced count from the ensembleui.com website.

App Flow Link - https://drive.google.com/file/d/1o7JjEDg0GbgIIybbCRTHxi04VgRJ2PuP/view?usp=share_link

## How it works?

```EnsembleExtensionStarter``` - iOS App<br>
```EnsembleExtension``` - iOS Safari Extension

EnsembleExtension (Safari Extension) iOS Target contains files like manifest.json, background.js, content.js, etc. Usually every extension will have the following files (ex: chrome extension)

You can also convert the existing chrome extension to the safari extension with this tool ```safari-web-extension-converter```.
https://developer.apple.com/documentation/safariservices/safari_web_extensions/converting_a_web_extension_for_safari

The ```content.js``` is injected to the web page and modify the text in the web page then it'll send message to the background.js with type "Word replaced" using ```browser.runtime.sendMessage()``` method.

In the ```background.js```, Listening for the message using ```browser.runtime.onMessage()``` method. Then checking for the type in the request which matches the request type "Word replaced". Now it'll send the message to the app extension with same type as a object/dict with ```message``` as a key.

In ```SafariWebExtensionHandler.swift``` file with the ```beginRequest()``` method, you can get the message from the web extension and stored it in UserDefaults. Here, we're using ```App Groups``` to communicate between the app and the extension.

From the ensemble app, we used ```ensembleExtension``` action (it's still in the development). which will call the platform channel method (ensembleExtension) declared in the ```AppDelegate.swift```. This method will return the string ```You've replaced (value) words``` to the ensemble app. In the ensemble app, it stores the result in the local storage (GetStorage) with the key ```WordReplacementData```. In the SafariExtensionApp ensemble definition, we declared a global function called getExtensionValue and assigned that value to the Text widget. 

So everytime, when you reload the web page (for ex: ensembleui.com) in Safari. Open the EnsembleExtensionStarter app and always click the Refresh button which will convert the user defaults value to get storage and then Get Value button will simply call the global function and assign the value to Text.


### NOTE:
```ensembleExtension``` action is still in the development. So it maybe deprecated in favor of using any other approach.

Also this starter project uses custom ensemble package which uses git ref (ios-extension) as a dependency in the pubspec.yaml.
