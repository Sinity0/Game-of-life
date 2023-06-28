//
//  World+Cells.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-13.
//

import Foundation

extension World {
    func aliveNeighbourCountAt(_ position: Position) -> Int {
        let neighbours: Set = [self[position.x - 1, position.y - 1],
                  self[position.x - 1, position.y],
                  self[position.x - 1, position.y + 1],
                  self[position.x, position.y - 1],
                  self[position.x, position.y + 1],
                  self[position.x + 1, position.y - 1],
                  self[position.x + 1, position.y],
                  self[position.x + 1, position.y + 1]]
        return neighbours.filter { $0?.isAlive ?? false }.count
    }
    
    func dyingCells() -> [Cell] {
        aliveCells.filter { !(2...3 ~= aliveNeighbourCountAt($0.position)) }
    }
    
    func revivingCells() -> [Cell] {
        deadCells.filter { aliveNeighbourCountAt($0.position) == 3 }
    }
    
    func state(at position: Position) -> Bool {
        let numberOfAliveNeighbours = aliveNeighbourCountAt(position)
        let wasPrevioslyAlive = cells[position]?.isAlive ?? false
        if wasPrevioslyAlive {
            return numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
        } else {
            return numberOfAliveNeighbours == 3
        }
    }
}
