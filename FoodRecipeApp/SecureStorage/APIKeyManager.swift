//
//  APIKeyManager.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 20/12/1446 AH.
//

import Foundation

/// A singleton class responsible for securely retrieving the API key from a local .plist file.
class APIKeyManager {
    
    /// Shared instance for global access.
    static let shared = APIKeyManager()
    
    /// Retrieves the API key from the `Secrets.plist` file.
    /// - Returns: The API key as a `String` if found, or a fallback `"No_API_Key_Found"` string.
    func getAPIKeyFromPlist() -> String {
        
        // Attempt to locate the Secrets.plist file in the main bundle
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           
            // Load the contents into a dictionary
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
           
            // Extract the API key using the specified key
           let key = dict["Recipe_API_KEY"] as? String {
            
            return key
        }
        
        // Fallback if the key is not found or file can't be read
        return "No_API_Key_Found"
    }
}
