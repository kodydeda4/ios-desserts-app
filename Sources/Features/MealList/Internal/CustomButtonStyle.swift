import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  var inFlight = false
  
  struct Theme {
    var textColor: Color
    var primaryColor: Color
    var borderColor: Color
    
    init(configuration: ButtonStyleConfiguration) {
      self.textColor = .primary
      self.primaryColor = configuration.isPressed ? .orange : Color(.systemBackground)
      self.borderColor = configuration.isPressed ? .orange : Color(.systemGray5)
    }
  }
  
  func makeBody(configuration: Self.Configuration) -> some View {
    let theme = Theme(configuration: configuration)
    
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
      theme.primaryColor
        .opacity(!configuration.isPressed ? 1 : 0.25)
        .overlay {
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .strokeBorder()
            .foregroundColor(theme.borderColor)
        }
    }
    .clipShape(RoundedRectangle(
      cornerRadius: 8,
      style: .continuous
    ))
    .shadow(color: Color.black.opacity(0.15), radius: 10, y: 4)
  }
}
