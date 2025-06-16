//
//  RecipeCardView.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 19/12/1446 AH.
//

import SwiftUI
import SDWebImageSwiftUI

/// A card-style view displaying recipe image, title, and publisher.
struct RecipeCardView: View {
    
    /// The recipe data model to populate the card content.
    let recipeObj: RecipeModel
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            // MARK: - Recipe Image
            WebImage(url: URL(string: recipeObj.featuredImage))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .frame(height: 120)
                .cornerRadius(10)
            
            // MARK: - Recipe Title
            Text(recipeObj.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
                .lineLimit(1) // Prevents text overflow
            
            // MARK: - Recipe Publisher
            Text(recipeObj.publisher)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding(15)
        .frame(height: 230)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.1), lineWidth: 1)
                .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
        }
    }
}



