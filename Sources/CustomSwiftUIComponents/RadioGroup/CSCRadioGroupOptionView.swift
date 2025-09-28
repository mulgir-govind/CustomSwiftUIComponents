//
//  CSCRadioGroupOptionView.swift
//  CustomSwiftUIComponents
//
//  Created by Personal on 28/09/25.
//

import SwiftUI

struct CSCRadioGroupOptionView<Option: CSCSelectableOption>: View {
    let option: Option
    @Binding var selectedOption: Option
    let style: CSCRadioGroupStyle

    private var isCurrentOptionSelected: Bool {
        option == selectedOption
    }

    private var radioIconColor: Color {
        isCurrentOptionSelected ? style.selectedOptionIconColor : style.unselectedOptionIconColor
    }

    private var backgroundColor: Color {
        isCurrentOptionSelected ? style.selectedOptionBackgroundColor : style.unselectedOptionBackgroundColor
    }

    var body: some View {
        HStack(alignment: .center, spacing: style.optionSpacig) {
            CSCRadioIconView(isSelected: isCurrentOptionSelected)
                .foregroundStyle(radioIconColor)

            Text(option.optionText)
                .font(style.optionFont)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: style.optionCorderRadious)
                .fill(backgroundColor)
        )
        .background(
            RoundedRectangle(cornerRadius: style.optionCorderRadious)
                .stroke(backgroundColor, lineWidth: style.optionBorderLineWidth)
        )
        .onTapGesture {
            withAnimation {
                selectedOption = option
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedOption: Gender = .male
    VStack {
        CSCRadioGroupOptionView(
            option: Gender.male,
            selectedOption: $selectedOption,
            style: CSCRadioGroupStyle()
        )

        CSCRadioGroupOptionView(
            option: Gender.female,
            selectedOption: $selectedOption,
            style: CSCRadioGroupStyle()
        )

        CSCRadioGroupOptionView(
            option: Gender.other,
            selectedOption: $selectedOption,
            style: CSCRadioGroupStyle()
        )
    }
    .padding()
}
