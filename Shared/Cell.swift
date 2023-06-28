//
//  Cell.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import UIKit

enum CellState: CaseIterable, Hashable {
    case dead, alive
}

struct Position: Equatable, Hashable {
    let x: Int, y: Int
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

class Cell: StatefullCell {
    var position: Position
    var state: CellState
    
    init(position: Position, state: CellState) {
        self.position = position
        self.state = state
    }
    
    var isAlive: Bool {
        get {
            state == .alive
        }
        
        set {
            state = newValue ? .alive : .dead
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.position == rhs.position && lhs.state == rhs.state && lhs.isAlive == rhs.isAlive
    }
}

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
