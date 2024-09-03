# Desserts
 
 Desserts is a native iOS app that allows users to browse recipes using `https://themealdb.com/api.php` API.


<!-- ## Architecture Overview -->

This example shows how an app can be built in a modular & scalable way using SPM (Swift-Package-Manager), TCA ([ComposableArchitecture](https://github.com/pointfreeco/swift-composable-architecture)), and Swift Concurrency.

## 1. Dependencies

Dependencies are separated between the interface & implementation to keep SwiftUI Previews fast. The live implementations are only imported when the app is ready to built for a device or simulator, and a preview implementation provides mock-data.

### 1. `ApiClient`

* Defines endpoints & models for the api.
* Provides a preview implementation with mock-data.

### 2. `ApiClient+live`

* Live implementation of the api-client.
* Wraps a private actor to make api-requests to the meal-db.

## 2. Features

Features are implemented as Reducers, with view-actions isolated in their own enum, so that actions sent to the store can be easily distinguished. The app has 3 features:

### 1. `AppReducer`

Root reducer of the app. You can add more features here if you like.

### 2. `MealList`

Feature that fetches & displays a list of meals from the api.

### 3. `MealDetails`

Feature that displays the details of a meal.

## 3. Library

### 1. `DesignSystem`

Contains Colors, Fonts, and View extensions that can be used in other features.