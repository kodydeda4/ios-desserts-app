import ApiClient
import ComposableArchitecture
import DesignSystem
import SwiftUI

@Reducer
public struct MealDetails {
  @ObservableState
  public struct State: Equatable {
    let meal: ApiClient.MealDetails
    
    public init(meal: ApiClient.MealDetails) {
      self.meal = meal
    }
  }
  
  public enum Action: ViewAction {
    case view(View)
    
    public enum View {
      case task
    }
  }
  
  public init() {}
  
  @Dependency(\.api) var api
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case let .view(action):
        switch action {
          
        case .task:
          return .none
        }
        
      default:
        return .none
        
      }
    }
  }
}

// MARK: - SwiftUI

@ViewAction(for: MealDetails.self)
public struct MealDetailsView: View {
  @Bindable public var store: StoreOf<MealDetails>
  
  public init(store: StoreOf<MealDetails>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      AsyncImage(url: URL(string: store.meal.strMealThumb)) { image in
        image.resizable().scaledToFit()
      } placeholder: {
        ProgressView()
      }
    }
    .navigationTitle(store.meal.strMeal)
  }
}

// MARK: - SwiftUI Previews

//#Preview {
//  NavigationStack {
//    MealDetailsView(store: Store(initialState: MealDetails.State(
//      meal: .previewValue
//    )) {
//      MealDetails()
//    })
//  }
//}
