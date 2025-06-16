//
//  HomeViewModel.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 19/12/1446 AH.
//

import Foundation
import Alamofire

/// ViewModel responsible for fetching and filtering recipes from the Food2Fork API.
class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// The list of loaded recipes.
    @Published var recipes: [RecipeModel] = []
    
    /// The current page being fetched in paginated results.
    @Published var currentPage: Int = 1
    
    /// The total number of available pages.
    @Published var totalPages: Int = 1
    
    /// A flag indicating if the view model is currently fetching data.
    @Published var isLoading: Bool = false
    
    /// The current search query entered by the user.
    @Published var searchText: String = ""
    
    // MARK: - API Fetch Method
    
    /// Fetches recipes from the API.
    func fetchRecipes() {
        
        // Prevent multiple requests if one is already in progress
        guard !isLoading else { return }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        // Construct API endpoint
        let url = "https://food2fork.ca/api/recipe/search/?page=\(currentPage)&query=beef carrot potato onion"
        
        // Retrieve API key from Secrets.plist
        let apiKey = APIKeyManager.shared.getAPIKeyFromPlist()
        
        // Prepare the HTTP headers with authorization token
        let headers: HTTPHeaders = ["Authorization": apiKey]
        
        // Perform network request using Alamofire
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: RecipeResponse.self) { response in
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    switch response.result {
                    case .success(let data):
                        // Append new recipes to the existing list
                        self.recipes.append(contentsOf: data.results)
                        self.currentPage += 1
                        self.totalPages = data.results.count
                        print("Recipes Loaded: \(data.results.count)")
                        
                    case .failure(let error):
                        print("Decoding error: \(error.localizedDescription)")
                    }
                }
            }
    }
    
    // MARK: - Search Filtering
    
    /// Filters the loaded recipes based on the user's search input.
    /// - Returns: An array of recipes matching the search text.
    var filteredRecipes: [RecipeModel] {
        recipes.filter { recipe in
            searchText.isEmpty || recipe.title.localizedCaseInsensitiveContains(searchText)
        }
    }
}
