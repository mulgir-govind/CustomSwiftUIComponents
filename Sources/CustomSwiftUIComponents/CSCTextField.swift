//
//  SwiftUIView.swift
//  CustomSwiftUIComponents
//
//  Created by Personal on 28/09/25.
//

import SwiftUI

public enum CSCTextFieldIconPosition {
    case none
    case leading
    case trailing
}

public struct CSCTextFieldConfig {
    var font: Font
    var textColor: Color
    var placeholderColor: Color
    var cornerRadius: CGFloat
    var borderColor: Color
    var borderWidth: CGFloat
    var padding: CGFloat

    public init(
        font: Font = .title3,
        textColor: Color = .primary,
        placeholderColor: Color = .secondary,
        cornerRadius: CGFloat = 12,
        borderColor: Color = .gray,
        borderWidth: CGFloat = 2,
        padding: CGFloat = 12
    ) {
        self.font = font
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.padding = padding
    }

    func getBorderColor(for state: CSCTextFieldState) -> Color {
        switch state {
            case .unknown: .gray
            case .valid: .green
            case .invalid: .red
        }
    }
}

public enum CSCTextFieldState {
    case unknown
    case valid
    case invalid(errorMessage: String?)
}

private struct CSCTextFieldStyle: ViewModifier {
    let config: CSCTextFieldConfig

    public func body(content: Content) -> some View {
        content
            .font(config.font)
            .foregroundColor(config.textColor)
            .padding(config.padding)
            .background(
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    .stroke(config.borderColor, lineWidth: config.borderWidth)
            )
    }
}

private extension View {
    func cscTextFieldStyle(config: CSCTextFieldConfig) -> some View {
        self.modifier(CSCTextFieldStyle(config: config))
    }
}

public struct CSCTextField: View {
    @Binding var textValue: String
    let labelText: String?
    let placeholderText: String?
    let systemImageName: String?
    let iconPosition: CSCTextFieldIconPosition
    var config: CSCTextFieldConfig

    // Validation closure
    var validation: ((String) -> CSCTextFieldState)?

    @State private var borderColor: Color
    @State private var isFirstTimeFocused: Bool = true
    @State private var currentState: CSCTextFieldState = .unknown

    @FocusState private var isFocused: Bool

    public init(
        textValue: Binding<String>,
        labelText: String? = nil,
        placeholderText: String? = nil,
        errorMessage: String? = nil,
        systemImageName: String? = nil,
        iconPosition: CSCTextFieldIconPosition = .trailing,
        config: CSCTextFieldConfig = CSCTextFieldConfig(),
        validation: ((String) -> CSCTextFieldState)? = nil) {
        self._textValue = textValue
        self.labelText = labelText
        self.placeholderText = placeholderText
        self.systemImageName = systemImageName
        self.iconPosition = iconPosition
        self.config = config
        self.validation = validation
        self._borderColor = State(initialValue: config.borderColor)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let labelText = labelText, !labelText.isEmpty {
                Text(labelText)
                    .font(config.font)
                    .foregroundColor(config.textColor)
            }

            HStack {
                if iconPosition == .leading, let systemImageName {
                    Image(systemName: systemImageName)
                        .font(config.font)
                        .foregroundColor(config.textColor)
                }
                
                TextField(
                    placeholderText ?? "",
                    text: $textValue
                )
                .textFieldStyle(.plain)
                .focused($isFocused)
                .onSubmit { runValidation() }
                .foregroundColor(config.textColor)

                if iconPosition == .trailing, let systemImageName {
                    Image(systemName: systemImageName)
                        .font(config.font)
                        .foregroundColor(config.textColor)
                }
            }
            .cscTextFieldStyle(config: configWithDynamicBorder())
            
            if case .invalid(let errorMessage) = currentState {
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(4)
        .onChange(of: isFocused, { oldValue, newValue in
            if !isFirstTimeFocused {
                runValidation()
            } else {
                isFirstTimeFocused = false
            }
        })
        .onChange(of: textValue, { oldValue, newValue in
            runValidation()
        })
    }

    private func runValidation() {
        if let validation = validation {
            let newState = validation(textValue)

            let newBorderColor: Color
            switch newState {
            case .unknown:
                newBorderColor = .gray
                break
            case .valid:
                newBorderColor = isFocused ? .green : .gray
            case .invalid(_):
                newBorderColor = isFirstTimeFocused ? .gray : .red
            }

            currentState = newState
            borderColor = newBorderColor.opacity(0.5)
        }
    }

    private func configWithDynamicBorder() -> CSCTextFieldConfig {
        var updated = config
        updated.borderColor = borderColor
        return updated
    }
}

#Preview {
    @Previewable @State var firstName: String = ""
    @Previewable @State var lastName: String = ""

    ScrollView {
        CSCTextField(
            textValue: $firstName,
            labelText: "First name",
            placeholderText: "Enter",
            systemImageName: "person.circle.fill") { value in
                if value.isEmpty {
                    return .invalid(errorMessage: "Value should be non-empty")
                } else if value.count <= 3 {
                    return .invalid(errorMessage: "Enter value greater than 3 charaters")
                } else if value.count > 20 {
                    return .invalid(errorMessage: "Enter value lower than 20 charaters")
                }
                return .valid
            }

        CSCTextField(
            textValue: $lastName,
            labelText: "Last name",
            placeholderText: "Enter",
            systemImageName: "calendar") { value in
                if value.isEmpty {
                    return .invalid(errorMessage: "Value should be non-empty")
                } else if value.count <= 3 {
                    return .invalid(errorMessage: "Enter value greater than 3 charaters")
                } else if value.count > 20 {
                    return .invalid(errorMessage: "Enter value lower than 20 charaters")
                }
                return .valid
            }
        
        Form {
            Button {
                
            } label: {
                Text("Save")
            }
        }
    }
    .padding(18)
}
