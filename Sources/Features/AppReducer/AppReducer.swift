import ApiClient
import ComposableArchitecture
import DesignSystem
import MealList
import SwiftUI

@Reducer
public struct AppReducer {
  @ObservableState
  public struct State: Equatable {
    var mealList = MealList.State(category: .dessert)
    
    public init() {}
  }
  
  public enum Action {
    case mealList(MealList.Action)
  }
  
  public init() {}
  
  @Dependency(\.api) var api
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.mealList, action: \.mealList) { MealList() }
      ._printChanges()
  }
}

// MARK: - SwiftUI

public struct AppView: View {
  @Bindable public var store: StoreOf<AppReducer>
  
  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      MealListView(store: store.scope(
        state: \.mealList,
        action: \.mealList
      ))
    }
  }
}

// MARK: - SwiftUI Previews

#Preview {
  AppView(store: Store(initialState: AppReducer.State()) {
    AppReducer()
  })
}
