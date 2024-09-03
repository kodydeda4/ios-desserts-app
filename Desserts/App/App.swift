import AppReducer
import DesignSystem
import SwiftUI
import XCTestDynamicOverlay

@main
struct MealsApp: App {
  init() {
    DesignSystem.registerFonts()
  }
  var body: some Scene {
    WindowGroup {
      if !_XCTIsTesting {
        AppView(store: .init(initialState: AppReducer.State()) {
          AppReducer()
        })
      }
    }
  }
}
