//
//  kataTests.swift
//  kataTests
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import XCTest
@testable import kata

class kataTests: XCTestCase {
    
    func testWorldDefaultCreation() {
        let world = WorldViewModel(dimensions: 10)
        XCTAssertTrue(world.cells.count == 100)
        XCTAssertTrue(world.dimensions == 10)
        XCTAssertNotNil(world[4,5])
    }

    func testWorldCreationWithIsEmptyFlag() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        XCTAssertTrue(world.cells.count == 100)
        XCTAssertTrue(world.dimensions == 10)
        XCTAssertTrue(world[4,5]?.isAlive == false)
        XCTAssertTrue(world[4,5]?.position == Position(x: 4, y: 5))
    }
    
    func testWorldBoundaries() {
        let world = WorldViewModel(dimensions: 10)
        XCTAssertNil(world[10,10])  // Outside the boundary
        XCTAssertNotNil(world[9,9]) // Edge of the world
    }
    
    func testSubscript() {
        let world = WorldViewModel(dimensions: 10,isEmpty: true)
        XCTAssertTrue(world[4,5] != nil)
        XCTAssertTrue(world[4,5]?.isAlive == false)
        XCTAssertTrue(world[4,5]?.position == Position(x: 4, y: 5))
    }
    
    func testUpdateCellState() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        XCTAssertFalse(world[4,5]?.isAlive ?? true) // should be dead
        world[4,5]?.isAlive = true
        XCTAssertTrue(world[4,5]?.isAlive ?? false) // should be alive now
    }
    
    func testAliveCells() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        world[2,1]?.isAlive = true
        world[2,2]?.isAlive = true
        
        XCTAssertTrue(world.world.aliveCells.count == 2)
        XCTAssertTrue(world.world.deadCells.count == 98)
    }
    
    func testLivingNeighboursSearch() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        world[0,1]?.isAlive = true
        world[1,0]?.isAlive = true
        
        XCTAssertTrue(world.world.aliveNeighbourCountAt(Position(x: 0, y: 0)) == 2)
        XCTAssertTrue(world.world.aliveNeighbourCountAt(Position(x: 1, y: 1)) == 2)
        XCTAssertTrue(world.world.aliveNeighbourCountAt(Position(x: 0, y: 1)) == 1)
        XCTAssertTrue(world.world.aliveNeighbourCountAt(Position(x: 2, y: 2)) == 0)
    }
    
    func testCellTransitions() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        world[0,1]?.isAlive = true
        world[1,0]?.isAlive = true
        world[4,4]?.isAlive = true
        world[4,5]?.isAlive = true
        world[5,4]?.isAlive = true
        XCTAssertTrue(world.world.dyingCells().count == 2)
        XCTAssertTrue(world.world.revivingCells().count == 1)
    }
    
    func testPerfomance() {
        let world = WorldViewModel(dimensions: 100)
        measure {
            for _ in 0...2 {
                world.tick()
            }
        }
    }
}
