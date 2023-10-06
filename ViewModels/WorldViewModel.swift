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
    
    func drawWorldToImage(world: WorldModel) -> UIImage? {
        let cellSize: CGFloat = 2.0
        let dimensions = world.dimensions
        let size = CGSize(width: CGFloat(dimensions) * cellSize, height: CGFloat(dimensions) * cellSize)

        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        for x in 0..<dimensions {
            for y in 0..<dimensions {
                let rect = CGRect(x: CGFloat(x) * cellSize, y: CGFloat(y) * cellSize, width: cellSize, height: cellSize)
                if let cell = world[x, y], cell.isAlive {
                    context.setFillColor(UIColor.black.cgColor)
                } else {
                    context.setFillColor(UIColor.white.cgColor)
                }
                context.fill(rect)
            }
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
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
