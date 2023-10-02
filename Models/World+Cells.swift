//
//  World+Cells.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-13.
//

import Foundation

extension WorldModel {
    func aliveNeighbourCountAt(_ position: Position) -> Int {
        if let cachedValue = neighbourCountCache[position] {
            return cachedValue
        }

        let neighbours: Set = [self[position.x - 1, position.y - 1],
                  self[position.x - 1, position.y],
                  self[position.x - 1, position.y + 1],
                  self[position.x, position.y - 1],
                  self[position.x, position.y + 1],
                  self[position.x + 1, position.y - 1],
                  self[position.x + 1, position.y],
                  self[position.x + 1, position.y + 1]]
        let count = neighbours.filter { $0?.isAlive ?? false }.count
        neighbourCountCache[position] = count
        return count
    }
    
    func revivingCells() -> [Cell] {
        var candidates: Set<Position> = []
        for aliveCell in aliveCells {
            let neighboursPositions: Set<Position> = [
                Position(x: aliveCell.position.x - 1, y: aliveCell.position.y - 1),
                Position(x: aliveCell.position.x - 1, y: aliveCell.position.y),
                Position(x: aliveCell.position.x - 1, y: aliveCell.position.y + 1),
                Position(x: aliveCell.position.x, y: aliveCell.position.y - 1),
                Position(x: aliveCell.position.x, y: aliveCell.position.y + 1),
                Position(x: aliveCell.position.x + 1, y: aliveCell.position.y - 1),
                Position(x: aliveCell.position.x + 1, y: aliveCell.position.y),
                Position(x: aliveCell.position.x + 1, y: aliveCell.position.y + 1)
            ]
            for neighbourPosition in neighboursPositions {
                if let cell = cells[neighbourPosition], !cell.isAlive {
                    candidates.insert(neighbourPosition)
                }
            }
        }

        return candidates.filter { aliveNeighbourCountAt($0) == 3 }.compactMap { cells[$0] }
    }
    
    func dyingCells() -> [Cell] {
        aliveCells.filter { !(2...3 ~= aliveNeighbourCountAt($0.position)) }
    }
    
//    func revivingCells() -> [Cell] {
//        deadCells.filter { aliveNeighbourCountAt($0.position) == 3 }
//    }
    
    func state(at position: Position) -> Bool {
        if let cachedState = cellStateCache[position] {
            return cachedState
        }

        var result = false
        let numberOfAliveNeighbours = aliveNeighbourCountAt(position)
        let wasPrevioslyAlive = cells[position]?.isAlive ?? false
        if wasPrevioslyAlive {
            result = numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
        } else {
            result =  numberOfAliveNeighbours == 3
        }
        
        cellStateCache[position] = result
        return result
    }
}
