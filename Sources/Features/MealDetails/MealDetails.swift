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
          print(state.meal)
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
    List {
      Section {
        AsyncImage(url: URL(string: store.meal.strMealThumb)) { image in
          image
            .resizable()
            .scaledToFit()
            .frame(height: 150)
            .frame(maxWidth: .infinity)
          
        } placeholder: {
          ProgressView()
            .frame(height: 150)
            .frame(maxWidth: .infinity)
        }
      }
      Section {
        DisclosureGroup("Ingredients") {
          ForEach(store.meal.ingredients) { value in
            HStack {
              Text(value.measurement)
              Text(value.ingredient)
            }
          }
        }
      }
      Section {
        DisclosureGroup("Instructions") {
          Text(store.meal.strInstructions)
        }
      }
    }
    .navigationTitle(store.meal.strMeal)
    .listStyle(.plain)
    .task { await send(.task).finish() }
  }
}

// MARK: - SwiftUI Previews

#Preview {
  Preview {
    NavigationStack {
      MealDetailsView(store: Store(initialState: MealDetails.State(
        meal: .previewValue
      )) {
        MealDetails()
      })
    }
  }
}
