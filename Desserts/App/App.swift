import AppReducer
import SwiftUI

@main
struct MealsApp: App {
  var body: some Scene {
    WindowGroup {
      AppView(store: .init(initialState: AppReducer.State()) {
        AppReducer()
      })
    }
  }
}
