//
//  WorldViewModel.swift
//  kata (iOS)
//
//  Created by Evgeny Mikhalkov on 2023-09-23.
//

import SwiftUI

class WorldViewModel: ObservableObject {
    @Published private(set) var world: WorldModel
    
    var dimensions: Int {
        world.dimensions
    }
    
    var cells: [Position: Cell] {
        world.cells
    }

    lazy var _memoNeighbours: [Cell: [Cell]] = [:]
    
    init(dimensions: Int, isEmpty: Bool = false) {
        self.world = WorldModel(dimensions: dimensions, isEmpty: isEmpty)
    }
    
    @objc func tick() {
        world.tick()
        objectWillChange.send()
    }

    func cell(at position: Position) -> CellViewModel? {
        guard let cell = world[position.x, position.y] else {
            return nil
        }
        
        return CellViewModel(cell: cell)
    }

    subscript(x: Int, y: Int) -> CellViewModel? {
        get {
            guard let cell = world[x, y] else {
                return nil
            }
            
            return CellViewModel(cell: cell)
        }
    }
}
