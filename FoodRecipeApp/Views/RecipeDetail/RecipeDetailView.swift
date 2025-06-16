//
//  RecipeDetailView.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 19/12/1446 AH.
//

import SwiftUI
import SDWebImageSwiftUI

/// A view that displays the detailed information of a selected recipe,
struct RecipeDetailView: View {
    
    // MARK: - Properties
    
    /// ViewModel responsible for fetching recipe details.
    @StateObject var viewModel = RecipeDetailViewModel()
    
    /// Environment dismiss function to close the view.
    @Environment(\.dismiss) var dismiss
    
    /// The ID of the recipe to be fetched and displayed.
    let recipeID: Int
    
    var body: some View {
        
        ScrollView {
            
            // MARK: - Header with Back, Title, and Favorite Button
            HStack(alignment: .bottom) {
                
                // Back button
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                // Header title
                Text("Recipe Detail")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.top)
                
                Spacer()
                
                // Favorite button toggle
                Button(action: {
                    viewModel.isFav.toggle()
                }) {
                    Image(viewModel.isFav ? "red_heart" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer().frame(height: 30)
            
            // MARK: - Recipe Content
            if let recipeObj = viewModel.recipe {
                
                VStack {
                    
                    // Recipe image
                    WebImage(url: URL(string: recipeObj.featuredImage))
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 115)
                        .cornerRadius(10)
                    
                    // Recipe title
                    Text(recipeObj.title)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Recipe publisher
                    Text(recipeObj.publisher)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Ingredients title
                    Text("Ingredients")
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    
                    // List of ingredients
                    LazyVStack {
                        ForEach(recipeObj.ingredients, id: \.self) { ingredient in
                            HStack {
                                Text("- \(ingredient)")
                                    .font(.system(size: 15))
                                    .padding(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    
                    // Source URL
                    HStack(alignment: .firstTextBaseline) {
                        Text("More Information")
                        Link("Here", destination: URL(string: recipeObj.sourceURL)!)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.vertical)
                    
                }
                .padding(.horizontal, 20)
            } else {
                
                ProgressView("Loading...")
            }
        }
        .navigationBarBackButtonHidden(true) // Hides default back button
        .navigationBarHidden(true) // Hides the navigation bar
        .onAppear {
            // Fetch recipe details when the view appears
            viewModel.fetchRecipeByID(recipeID)
        }
    }
}
