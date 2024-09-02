// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "ios-desserts-app",
  products: [
    .library(
      name: "ios-desserts-app",
      targets: ["ios-desserts-app"]
    ),
  ],
  targets: [
    .target(
      name: "ios-desserts-app"
    ),
    .testTarget(
      name: "ios-desserts-appTests",
      dependencies: ["ios-desserts-app"]
    ),
  ]
)
