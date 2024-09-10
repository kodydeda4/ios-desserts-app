import Foundation

extension ApiClient {
  public enum MealCategory: String, Equatable, Codable {
    case dessert = "Dessert"
  }
}

// MARK: - Public Extensions

extension ApiClient.MealCategory: Identifiable {
  public var id: Self { self }
}

extension ApiClient.MealCategory: CustomStringConvertible {
  public var description: String { rawValue }
}
