//
//  SwiftUIView.swift
//  CustomSwiftUIComponents
//
//  Created by Personal on 28/09/25.
//

import SwiftUI

public struct CSCRadioGroupView<Option: CSCSelectableOption>: View {
    let labelText: String
    let options: [Option]
    @Binding var selectedOption: Option
    let style: CSCRadioGroupStyle

    private var selectedLayout: AnyLayout {
        switch style.layoutType {
            case .horizontal:
                AnyLayout(HStackLayout(alignment: .center, spacing: style.optionSpacig))
            case .vertical:
                AnyLayout(VStackLayout(alignment: .leading, spacing: style.optionSpacig))
        }
    }

    private var scrollViewAxis: Axis.Set {
        switch style.layoutType {
        case .horizontal:
            Axis.Set.horizontal
        case .vertical:
            Axis.Set.vertical
        }
    }

    public var body: some View {
        ScrollView(scrollViewAxis, showsIndicators: false) {
            VStack(alignment: .leading, spacing: style.optionSpacig) {
                Text(labelText)
                    .font(style.labelFont)
                    .foregroundStyle(style.labelColor)

                selectedLayout {
                    ForEach(options) { option in
                        CSCRadioGroupOptionView(
                            option: option,
                            selectedOption: $selectedOption,
                            style: style
                        )
                        .frame(width: style.optionMaxWidth)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var gender: Gender = .male
    @Previewable @State var theme: Appearance = .light
    VStack(spacing: 12) {
        CSCRadioGroupView(
            labelText: "Select your gender",
            options: Gender.allCases,
            selectedOption: $gender,
            style: CSCRadioGroupStyle(layoutType: .horizontal)
        )

        Divider()

        CSCRadioGroupView(
            labelText: "Select theme:",
            options: Appearance.allCases,
            selectedOption: $theme,
            style: CSCRadioGroupStyle(
                selectedOptionIconColor: .black,
                selectedOptionBackgroundColor: .yellow.opacity(0.3),
                layoutType: .vertical
            )
        )
        .frame(height: 200)
    }
    .padding()
}
