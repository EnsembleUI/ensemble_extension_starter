//
//  SafariWebExtensionHandler.swift
//  EnsembleExtension
//
//  Created by Vinoth Vino on 06/06/23.
//

import SafariServices
import os.log

// Communicates with the extension running in Safari.
class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        // Unpack the message from Safari Web Extension.
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        // Update the value in UserDefaults.
        let defaults = UserDefaults(suiteName: "group.com.example.ensembleExtensionStarter")
        let messageDictionary = message as? [String: String]
        if messageDictionary?["message"] == "Word replaced" {
            var currentValue = defaults?.integer(forKey: "WordReplacementCount") ?? 0
            currentValue += 1
            defaults?.set(currentValue, forKey: "WordReplacementCount")
        }

        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]
        
        context.completeRequest(returningItems: [response], completionHandler: nil)
    }

}

