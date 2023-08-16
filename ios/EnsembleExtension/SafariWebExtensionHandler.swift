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
    
    static let groupId: String = "group.com.example.ensembleExtensionStarter"

    func beginRequest(with context: NSExtensionContext) {
        // Unpack the message from Safari Web Extension.
        let item = context.inputItems[0] as! NSExtensionItem
        let message = item.userInfo?[SFExtensionMessageKey]
        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@", message as! CVarArg)

        let messageDictionary = message as? [String: String]
        // Keychain
        if messageDictionary?["message"] == "tokenExchange" {
            // Read Token from Keychain
            let value = KeychainService().read(key: "authToken", groupId: SafariWebExtensionHandler.groupId, accountName: nil, synchronizable: nil)
            print("AuthToken value: \(value)")
        }

        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]
        
        context.completeRequest(returningItems: [response], completionHandler: nil)
    }

}

