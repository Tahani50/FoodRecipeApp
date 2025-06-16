//
//  HomeView.swift
//  FoodRecipeApp
//
//  Created by Tahani Ayman on 19/12/1446 AH.
//

import SwiftUI

/// The main home screen displaying a searchable, paginated list of recipe cards.
struct HomeView: View {
    
    // MARK: - Properties

    /// ViewModel responsible for fetching and filtering recipe data.
    @StateObject private var viewModel = HomeViewModel()
    
    /// Grid layout configuration for displaying recipe cards.
    var colums = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Header Title and Filter Icon
                HStack(alignment: .bottom) {
                    
                    Text("Meals Recipes")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top)
                    
                    Spacer()
                    
                    Image("funnel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                .padding(.horizontal, 20)
                
                // MARK: - Search Bar
                SearchBarView(searchText: $viewModel.searchText)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                
                // MARK: - Recipe Grid List
                if viewModel.isLoading && viewModel.recipes.isEmpty {
                    
                    ProgressView("Loading...")
                    
                } else if viewModel.filteredRecipes.isEmpty {
                    
                    VStack {
                        
                        Image("empty_search")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.gray)
                        
                        Text("No Results Found")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(showsIndicators: false) {
                        
                        LazyVGrid(columns: colums, spacing: 15) {
                            ForEach(viewModel.filteredRecipes, id: \.id) { recipe in
                                NavigationLink {
                                    RecipeDetailView(recipeID: recipe.id)
                                } label: {
                                    RecipeCardView(recipeObj: recipe)
                                }
                            }
                        }
                        .padding(20)
                        
                        // MARK: - Load More Button
                        if !viewModel.recipes.isEmpty && viewModel.currentPage <= viewModel.totalPages {
                            Button(action: {
                                viewModel.fetchRecipes()
                            }) {
                                Text("Load More")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                            .background(.black)
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 8)
                }
                
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                // Fetch recipes when the view appears
                viewModel.fetchRecipes()
            }
        }
    }
}


#Preview {
    HomeView()
}
