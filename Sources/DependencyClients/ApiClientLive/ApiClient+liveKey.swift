import ApiClient
import ComposableArchitecture
import Foundation
import Tagged

extension ApiClient: DependencyKey {
  public static var liveValue: Self {
    let api = ApiActor()

    return Self(
      fetchAllMeals: { category in
        struct Response: Codable {
          let meals: [ApiClient.Meal]
        }
        let response: Response = try await api.request(
          "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        )
        return response.meals
      },
      fetchMealDetailsById: { id in
        struct Response: Codable {
          let meals: [ApiClient.MealDetails]
        }
        let response: Response = try await api.request(
          "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        )
        return response.meals
      }
    )
  }
}

// MARK: - Private Extensions

private extension ApiClient {
  final actor ApiActor {
    @Sendable func request<T: Decodable>(_ url: String) async throws -> T {
      guard let url = URL(string: url) else {
        throw URLError(.badURL)
      }

      let (data, response) = try await URLSession.shared.data(from: url)

      // Check for valid HTTP response
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
      else {
        throw URLError(.badServerResponse)
      }

      // Decode the JSON data to the specified type
      do {
        let response = try JSONDecoder().decode(T.self, from: data)
        return response
      } catch {
        print("Failed to decode type.")
        throw error
      }
    }
  }
}
