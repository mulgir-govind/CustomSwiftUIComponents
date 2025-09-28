//
//  CSCRadioGroupStyle.swift
//  CustomSwiftUIComponents
//
//  Created by Personal on 28/09/25.
//
import SwiftUI

struct CSCRadioGroupStyle {
    // Group label
    let labelFont: Font
    let labelColor: Color

    // Radio option
    let optionFont: Font
    let optionColor: Color

    // Radio icon color
    let selectedOptionIconColor: Color
    let unselectedOptionIconColor: Color
    
    let selectedOptionBackgroundColor: Color
    let unselectedOptionBackgroundColor: Color

    // Option container
    let optionMaxWidth: CGFloat
    let optionSpacig: CGFloat
    let optionCorderRadious: CGFloat
    let optionBorderLineWidth: CGFloat

    // Layout
    let layoutType: CSCViewLayoutType

    public init(labelFont: Font = .title2,
                labelColor: Color = .primary,
                optionFont: Font = .title2,
                optionColor: Color = .primary,
                selectedOptionIconColor: Color = .accentColor,
                unselectedOptionIconColor: Color = .secondary,
                selectedOptionBackgroundColor: Color = .blue.opacity(0.3),
                unselectedOptionBackgroundColor: Color = .gray.opacity(0.2),
                optionMaxWidth: CGFloat = .infinity,
                optionSpacig: CGFloat = 12,
                optionCorderRadious: CGFloat = 12,
                optionBackgroundColor: Color = .blue.opacity(0.2),
                optionBorderLineWidth: CGFloat = 2,
                layoutType: CSCViewLayoutType = .vertical) {
        self.labelFont = labelFont
        self.labelColor = labelColor
        self.optionFont = optionFont
        self.optionColor = optionColor
        self.selectedOptionIconColor = selectedOptionIconColor
        self.unselectedOptionIconColor = unselectedOptionIconColor
        self.selectedOptionBackgroundColor = selectedOptionBackgroundColor
        self.unselectedOptionBackgroundColor = unselectedOptionBackgroundColor
        self.optionMaxWidth = optionMaxWidth
        self.optionSpacig = optionSpacig
        self.optionCorderRadious = optionCorderRadious
        self.optionBorderLineWidth = optionBorderLineWidth
        self.layoutType = layoutType
    }
}
