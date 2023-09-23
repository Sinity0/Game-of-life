//
//  Color.swift
//  kata (iOS)
//
//  Created by Evgeny Mikhalkov on 2023-09-23.
//

import SwiftUI

extension Color {
    var uiColor: UIColor {
        if self == Color.green {
            return UIColor.green
        } else if self == Color.gray {
            return UIColor.gray
        }
        
        return UIColor.clear
    }
}
