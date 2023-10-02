//
//  World.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import UIKit

class WorldModel {
    var cells: [Position: Cell]
    var dimensions: Int
    
    var aliveCells: [Cell] {
        cells.filter { $0.value.isAlive }.map { $0.value }
    }
    
    var deadCells: [Cell] {
        cells.filter { !$0.value.isAlive }.map { $0.value }
    }
    
    var neighbourCountCache: [Position: Int] = [:]
    var cellStateCache: [Position: Bool] = [:]

    init(dimensions: Int, isEmpty: Bool = false) {
        cells = [:]
        self.dimensions = dimensions
        
        for x in 0..<dimensions {
            for y in 0..<dimensions {
                let position = Position(x: x, y: y)
                cells[position] =
                    Cell(
                        position: position,
                        //state: isEmpty ? .dead : Int.random(in: 1...10) == 1 ? .alive : .dead
                        state: .dead
                    )
            }
        }
        
        // Glider pattern
        cells[Position(x: 1, y: 0)]?.isAlive = true
        cells[Position(x: 2, y: 1)]?.isAlive = true
        cells[Position(x: 0, y: 2)]?.isAlive = true
        cells[Position(x: 1, y: 2)]?.isAlive = true
        cells[Position(x: 2, y: 2)]?.isAlive = true
    }
    
    func tick() {
        neighbourCountCache.removeAll()
        cellStateCache.removeAll()
        var nextStates: [Position: Bool] = [:]
        for position in cells.keys {
            nextStates[position] = state(at: position)
        }
        for (position, isAlive) in nextStates {
            cells[position]?.isAlive = isAlive
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
