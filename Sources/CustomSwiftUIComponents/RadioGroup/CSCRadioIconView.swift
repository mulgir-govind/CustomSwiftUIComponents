//
//  SwiftUIView.swift
//  CustomSwiftUIComponents
//
//  Created by Personal on 28/09/25.
//

import SwiftUI

internal struct CSCRadioIconView: View {
    let isSelected: Bool

    private let innerIconName = "circle.fill"
    private let outerIconName = "circle"

    var body: some View {
        ZStack {
            if isSelected {
                Image(systemName: innerIconName)
                    .font(.caption)
            }

            Image(systemName: outerIconName)
                .font(.title2)
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        CSCRadioIconView(isSelected: true)
        CSCRadioIconView(isSelected: false)
    }
    .padding()
}
