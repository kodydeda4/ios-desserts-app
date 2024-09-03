import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  var inFlight = false
  
  struct Theme {
    var textColor: Color
    var primaryColor: Color
    var borderColor: Color
    
    init(inFlight: Bool, configuration: ButtonStyleConfiguration) {
      let isActive = inFlight || configuration.isPressed
      self.textColor = .primary
      self.primaryColor = isActive ? .orange : Color(.systemBackground)
      self.borderColor = isActive ? .orange : Color(.systemGray5)
    }
  }
  
  func makeBody(configuration: Self.Configuration) -> some View {
    let theme = Theme(inFlight: inFlight, configuration: configuration)
    
    HStack {
      configuration.label
      Spacer()
      if inFlight {
        ProgressView()
      } else {
        Image(systemName: "chevron.forward")
      }
    }
    .padding()
    .foregroundColor(theme.textColor)
    .frame(height: 8*3)
    .padding(.vertical, 12)
    .frame(maxWidth: .infinity)
    .background {
      theme.primaryColor.opacity(!(configuration.isPressed || inFlight) ? 1 : 0.25).overlay {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
          .strokeBorder()
          .foregroundColor(theme.borderColor)
      }
    }
    .clipShape(RoundedRectangle(
      cornerRadius: 8,
      style: .continuous
    ))
    .shadow(color: Color.black.opacity(0.15), radius: 4, y: 2)
  }
}
