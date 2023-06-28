//
//  World.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import Foundation

class World: ObservableObject {
    @Published private(set) var cells: [Position: Cell]
    @Published private(set) var dimensions: Int
    
    var aliveCells: [Cell] {
        let c = cells.filter { $0.value.isAlive }
        return c.map { $0.value }
    }
    
    var deadCells: [Cell] {
        let c = cells.filter { !$0.value.isAlive }
        return c.map { $0.value }
    }
    
    lazy var _memoNeighbours: [Cell: [Cell]] = [:]

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
    
    @objc func tick() {
        _ = cells.map { $0.value.isAlive = state(at: $0.value.position)}
        objectWillChange.send()
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
