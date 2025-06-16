//
//  RecipeDetailViewModel.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 20/12/1446 AH.
//

import Foundation
import Alamofire

/// ViewModel responsible for fetching detailed recipe information from the API
/// based on a given recipe ID and managing favorite status.
class RecipeDetailViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// The fetched recipe object.
    @Published var recipe: RecipeModel? = nil
    
    /// A flag indicating if the view model is currently fetching data.
    @Published var isLoading: Bool = false
    
    /// A flag representing whether the recipe is marked as a favorite.
    @Published var isFav: Bool = false
    
    // MARK: - API Fetch Method
    
    /// Fetches recipe information using its ID.
    /// - Parameter id: The unique identifier of the recipe to fetch.
    func fetchRecipeByID(_ id: Int) {
        
        // Prevent multiple requests if one is already in progress
        guard !isLoading else { return }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        // Construct API endpoint
        let url = "https://food2fork.ca/api/recipe/get/?id=\(id)"
        
        // Retrieve API key from Secrets.plist
        let apiKey = APIKeyManager.shared.getAPIKeyFromPlist()
        
        // Prepare the HTTP headers with authorization token
        let headers: HTTPHeaders = [
            "Authorization": apiKey
        ]
        
        // Perform the network request using Alamofire
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: RecipeModel.self) { response in
                
                // Update UI on the main thread
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    switch response.result {
                    case .success(let data):
                        // Save loaded recipe
                        self.recipe = data
                        print("Recipe Loaded: \(data.title)")
                        
                    case .failure(let error):
                        print("Decoding error: \(error.localizedDescription)")
                    }
                }
            }
    }
}
