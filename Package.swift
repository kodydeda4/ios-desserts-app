// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "ios-desserts-app",
  platforms: [.iOS(.v17)],
  products: [
    // Dependencies
    .library(name: "ApiClient"),

    // Features
    .library(name: "AppReducer"),
    .library(name: "MealList"),
    .library(name: "MealDetails"),

    // Libraries
    .library(name: "DesignSystem"),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.6.0"),
    .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro", branch: "main"),
  ],
  targets: [
    // Dependencies
    .dependency("ApiClient"),
    .dependency("ApiClientLive", dependencies: [
      "ApiClient"
    ]),

    // Features
    .feature("AppReducer", dependencies: [
      "ApiClientLive",
      "MealList",
      "MealDetails"
    ]),
    .feature("MealList", dependencies: [
      "ApiClient",
      "MealDetails"
    ]),
    .feature("MealDetails", dependencies: [
      "ApiClient",
    ]),

    // Libraries
    .library("DesignSystem", resources: [.process("Fonts")]),
  ]
)

// MARK: - Helpers

extension Product {

  /// Create a library with identical name & target.
  static func library(name: String) -> Product {
    .library(name: name, targets: [name])
  }
}

extension Target {

  /// Create a target with the default path & dependencies for a feature.
  static func feature(_ name: String, dependencies: [Target.Dependency] = []) -> Target {
    .target(
      name: name,
      dependencies: dependencies + [
        "DesignSystem",
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies"),
        .product(name: "Tagged", package: "swift-tagged"),
      ],
      path: "Sources/Features/\(name)"
    )
  }

  /// Create a target with the default path & dependencies for a dependency.
  static func dependency(_ name: String, dependencies: [Target.Dependency] = []) -> Target {
    .target(
      name: name,
      dependencies: dependencies + [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Tagged", package: "swift-tagged"),
        .product(name: "MemberwiseInit", package: "swift-memberwise-init-macro"),
      ],
      path: "Sources/Dependencies/\(name)"
    )
  }

  /// Create a target with the default path & dependencies for a library.
  static func library(
    _ name: String,
    dependencies: [Target.Dependency] = [],
    resources: [Resource] = []
  ) -> Target {
    .target(
      name: name,
      dependencies: dependencies,
      path: "Sources/Library/\(name)",
      resources: resources
    )
  }
}
