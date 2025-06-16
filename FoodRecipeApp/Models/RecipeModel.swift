//
//  RecipeModel.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 19/12/1446 AH.
//

import Foundation

/// A model representing a recipe item retrieved from the Food2Fork API.
struct RecipeModel: Identifiable, Codable {
    
    var id: Int
    var title: String
    var publisher: String
    var featuredImage: String
    var rating: Int
    var sourceURL: String
    var description: String
    var cookingInstructions: String?
    var ingredients: [String]
    var dateAdded: String
    var dateUpdated: String
    var longDateAdded: Int
    var longDateUpdated: Int

    /// Maps JSON keys to Swift property names.
    enum CodingKeys: String, CodingKey {
        case id = "pk"
        case title = "title"
        case publisher = "publisher"
        case featuredImage = "featured_image"
        case rating = "rating"
        case sourceURL = "source_url"
        case description = "description"
        case cookingInstructions = "cooking_instructions"
        case ingredients = "ingredients"
        case dateAdded = "date_added"
        case dateUpdated = "date_updated"
        case longDateAdded = "long_date_added"
        case longDateUpdated = "long_date_updated"
    }
}

