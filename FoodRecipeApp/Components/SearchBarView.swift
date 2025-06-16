//
//  SearchBarView.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 19/12/1446 AH.
//

import SwiftUI

/// A search bar view for filtering meal recipes.
struct SearchBarView: View {
    
    /// Binding to the parent view’s search text state.
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 15) {
            
            // MARK: - Search Icon
            Image("magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            // MARK: - Search Text Field
            TextField("Search meal name", text: $searchText)
                .autocapitalization(.none) // Prevents capitalizing first letter
                .disableAutocorrection(true) // Disables iOS spellcheck suggestions
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(height: 15)
        .padding(15)
        .background(Color.black.opacity(0.05))
        .cornerRadius(8)
    }
}



