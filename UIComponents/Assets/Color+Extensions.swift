//
//  Color+Extensions.swift
//  UIComponents
//
//  Created by Fernando Florez on 3/02/24.
//

import SwiftUI

enum ColorName: String {
    case textFieldTextColor
    case textFieldBoder
    case textFieldBorderFocused
    case textFieldLabel
}

extension Color {
    init(fromAssets name: ColorName) {
        self.init(Color(name.rawValue))
    }
    
    init(withHex hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }
}
