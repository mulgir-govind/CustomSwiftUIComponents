//
//  Gender.swift
//  CustomSwiftUIComponents
//
//  Created by Personal on 28/09/25.
//

import Foundation

enum Gender: Int, CSCSelectableOption, CaseIterable {
    case male
    case female
    case other
    case undisclosed

    var id: Int {
        self.rawValue
    }

    var optionText: String {
        switch self {
        case .male:
            "Male"
        case .female:
            "Female"
        case .other:
            "Other"
        case .undisclosed:
            "Undisclosed"
        }
    }
}

enum Appearance: Int, CSCSelectableOption, CaseIterable {
    case light
    case dark
    
    var id: Int {
        self.rawValue
    }
    
    var optionText: String {
        switch self {
        case .light:
            "Light sdfsd sd fs dfsd fs df sdf s dfs df sdf s dfs d"
        case .dark:
            "Dark"
        }
    }
}
