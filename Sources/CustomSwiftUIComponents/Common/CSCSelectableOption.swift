//
//  CSCSelectableOption.swift
//  CustomSwiftUIComponents
//
//  Created by Personal on 28/09/25.
//
import Foundation

public protocol CSCSelectableOption: Hashable, Identifiable {
    var optionText: String { get }
}
