//
//  LayerCell.swift
//  kata (iOS)
//
//  Created by Evgeny Mikhalkov on 2023-09-23.
//

import UIKit

class LayerCell: Hashable {
    private var layers: [Position: CALayer] = [:]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    static func == (lhs: LayerCell, rhs: LayerCell) -> Bool {
        true
    }

    subscript(x: Int, y: Int) -> CALayer? {
        get {
            layers[Position(x: x, y: y)]
        }

        set {
            guard let _newValue = newValue else {
                return
            }

            layers[Position(x: x, y: y)] = _newValue
        }
    }
}
