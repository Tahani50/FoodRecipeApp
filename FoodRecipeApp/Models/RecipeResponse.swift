//
//  RecipeResponse.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 20/12/1446 AH.
//

import Foundation

/// A response model representing recipe results from the Food2Fork API.
struct RecipeResponse: Codable {
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [RecipeModel]
}
