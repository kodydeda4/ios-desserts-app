import Dependencies
import DependenciesMacros
import Foundation
import MemberwiseInit
import Tagged

@DependencyClient
public struct ApiClient: Sendable {
  public var fetchAllMeals: @Sendable (MealCategory) async throws -> [Meal]
  public var fetchMealDetailsById: @Sendable (Meal.ID) async throws -> [MealDetails]
}

extension ApiClient: TestDependencyKey {
  public static var testValue = Self()
}

extension DependencyValues {
  public var api: ApiClient {
    get { self[ApiClient.self] }
    set { self[ApiClient.self] = newValue }
  }
}
