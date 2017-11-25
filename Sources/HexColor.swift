//
//  HexColor.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// HexColor representation
public struct HexColor {
    
    /// Hex value as string
    public let value: String
    
    private let characterSet = CharacterSet(charactersIn: "0123456789abcdef")
    
    /// Creates a new instance of the hex color using the given string
    ///
    /// - parameter value: The string value of the hex color
    ///
    /// - returns: The new instance
    public init?(_ value: String) {
        let lowerValue = value.lowercased()
        let trimmedValue = value.trimmingCharacters(in: characterSet)
        guard trimmedValue.count == 0 else {
            return nil
        }
        self.value = lowerValue
    }
}

