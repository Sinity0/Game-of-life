//
//  World.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import Foundation

class WorldModel {
    var cells: [Position: Cell]
    var dimensions: Int
    
    var aliveCells: [Cell] {
        cells.filter { $0.value.isAlive }.map { $0.value }
    }
    
    var deadCells: [Cell] {
        cells.filter { !$0.value.isAlive }.map { $0.value }
    }

    init(dimensions: Int, isEmpty: Bool = false) {
        cells = [:]
        self.dimensions = dimensions
        
        for x in 0..<dimensions {
            for y in 0..<dimensions {
                let position = Position(x: x, y: y)
                cells[position] =
                    Cell(
                        position: position,
                        state: isEmpty ? .dead : Int.random(in: 1...10) == 1 ? .alive : .dead
                    )
            }
        }
    }
    
    func tick() {
        for position in cells.keys {
            if let cell = cells[position] {
                cell.isAlive = state(at: position)
            }
        }
    }

    subscript(x: Int, y: Int) -> Cell? {
        get {
            cells[Position(x: x, y: y)]
        }
        
        set {
            guard let _newValue = newValue else {
                return
            }
            
            cells[Position(x: x, y: y)] = _newValue
        }
    }
}
