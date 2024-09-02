import ApiClient
import ComposableArchitecture
import DesignSystem
import MealDetails
import SwiftUI

@Reducer
public struct MealList {
  @ObservableState
  public struct State: Equatable {
    let category: ApiClient.MealCategory
    var rows = IdentifiedArrayOf<Row>()
    @Presents var destination: Destination.State?
    
    struct Row: Identifiable, Equatable {
      var id: ApiClient.Meal.ID { meal.id }
      let meal: ApiClient.Meal
      var inFlight = false
    }
    
    public init(category: ApiClient.MealCategory) {
      self.category = category
    }
  }
  
  public enum Action: ViewAction {
    case view(View)
    case destination(PresentationAction<Destination.Action>)
    case fetchMealsResponse(Result<[ApiClient.Meal], Error>)
    case fetchMealDetailsResponse(Result<[ApiClient.MealDetails], Error>)
    
    public enum View {
      case task
      case navigateToMealDetails(id: ApiClient.Meal.ID)
    }
  }
  
  public init() {}
  
  @Dependency(\.api) var api
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case let .fetchMealsResponse(result):
        switch result {
          
        case let .success(value):
          state.rows = IdentifiedArrayOf(uniqueElements: value.map { State.Row(meal: $0) })
          return .none
          
        case let .failure(error):
          print(error.localizedDescription)
          return .none
        }
        
      case let .fetchMealDetailsResponse(result):
        switch result {
          
        case let .success(value):
          if let first = value.first {
            state.destination = .mealDetails(MealDetails.State(meal: first))
          }
          return .none
          
        case let .failure(error):
          print(error.localizedDescription)
          return .none
        }
        
      case let .view(action):
        switch action {
          
        case .task:
          return .run { [category = state.category] send in
            await send(.fetchMealsResponse(Result {
              try await self.api.fetchAllMeals(category)
            }))
          }
          
        case let .navigateToMealDetails(id):
          state.rows[id: id]?.inFlight = true
          return .run { send in
            
          }
        }
        
      default:
        return .none
        
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
  
  @Reducer(state: .equatable)
  public enum Destination {
    case mealDetails(MealDetails)
  }
}


// MARK: - SwiftUI

@ViewAction(for: MealList.self)
public struct MealListView: View {
  @Bindable public var store: StoreOf<MealList>
  
  public init(store: StoreOf<MealList>) {
    self.store = store
  }
  
  public var body: some View {
    List {
      ForEach(store.rows) { row in
        rowView(row)
      }
    }
    .task { await send(.task).finish() }
    .navigationTitle(store.category.description)
    .navigationDestination(item: $store.scope(
      state: \.destination?.mealDetails,
      action: \.destination.mealDetails
    )) { store in
      MealDetailsView(store: store)
    }
  }
  
  @MainActor private func rowView(_ row: MealList.State.Row) -> some View {
    Button(action: { send(.navigateToMealDetails(id: row.id)) }) {
      HStack {
        Text(row.meal.strMeal)
        
        if row.inFlight {
          ProgressView()
        }
      }
    }
  }
}

// MARK: - SwiftUI Previews

#Preview {
  NavigationStack {
    MealListView(store: Store(initialState: MealList.State(
      category: .dessert
    )) {
      MealList()
    })
  }
}
