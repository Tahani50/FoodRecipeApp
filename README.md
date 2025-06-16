
# 🍽️ Food Recipe App

A clean and modern **SwiftUI Food Recipe App** powered by the [Food2Fork API](https://www.food2fork.ca/). This app allows users to browse delicious meals with **pagination**, **search by recipe name**, and **detailed recipe views** including ingredients and source links.

---

## 🚀 Features

- 🔍 **Search Recipes** by meal name using a responsive search bar
- 📄 **Recipe Detail View** showing image, publisher, ingredients, and source link
- 🔁 **Pagination Support** with "Load More" functionality
- ❤️ **Favorite Toggle** (UI-only for now)
- 🔐 **Secure API Key Handling** using `Secrets.plist`
- ✅ Fully built with **SwiftUI** and **MVVM architecture**

---

## 🧱 Folder Structure

```
├── Components/
│   ├── RecipeCardView.swift       // Displays a single recipe in a card format
│   └── SearchBarView.swift        // Custom search text field with icon
│
├── Models/
│   ├── RecipeModel.swift          // Data model representing a single recipe
│   └── RecipeResponse.swift       // Model for paginated API response
│
├── SecureStorage/
│   ├── APIKeyManager.swift        // Singleton to securely load API key
│   └── Secrets.plist              // Contains the API key
│
├── Views/
│   ├── Home/
│   │   ├── HomeView.swift         // Main screen with search and paginated list
│   │   └── HomeViewModel.swift    // Handles API requests and filtering
│   │
│   └── RecipeDetail/
│       ├── RecipeDetailView.swift     // Displays full recipe details
│       └── RecipeDetailViewModel.swift// Handles fetching a single recipe by ID
```

---

## 🛠️ How It Works

### 🔐 Secure API Key Loading
The API key is stored in a `Secrets.plist` file and accessed via a singleton `APIKeyManager`. This ensures no hardcoded sensitive information.

### 🌐 API Integration
The app integrates with the following endpoints from Food2Fork:

- `GET /api/recipe/search/?page=1&query=...` → Paginated recipe list
- `GET /api/recipe/get/?id=123` → Fetch specific recipe by ID

Both endpoints require an `Authorization` header using the token from the API key.

### 🧭 View Navigation

- **HomeView** shows a search bar and list of recipes
- Each recipe links to **RecipeDetailView** via `NavigationLink`, passing the recipe ID
- The detail view fetches full information on appear using the ID

---

## 📦 Dependencies

- [Alamofire](https://github.com/Alamofire/Alamofire) – for networking
- [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) – for async image loading with caching

---

## 🧪 Future Enhancements

- ✅ Persist favorites using `UserDefaults` or `Firebase`
- 📦 Caching for offline access
- 🌐 Language/localization support
- 💡 Dark mode optimization

