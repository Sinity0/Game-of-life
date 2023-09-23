//
//  kataTests.swift
//  kataTests
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import XCTest
@testable import kata

class kataTests: XCTestCase {
    
    func testWorldCreation() {
        let world = WorldViewModel(dimensions: 10)
        XCTAssertTrue(world.cells.count == 100)
        XCTAssertTrue(world.dimensions == 10)
    }
    
    func testSubscript() {
        let world = WorldViewModel(dimensions: 10,isEmpty: true)
        XCTAssertTrue(world[4,5] != nil)
        XCTAssertTrue(world[4,5]?.isAlive == false)
        XCTAssertTrue(world[4,5]?.position == Position(x: 4, y: 5))
    }
    
    func testAliveCells() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        world[2,1]?.isAlive = true
        world[2,2]?.isAlive = true
        
        XCTAssertTrue(world.aliveCells.count == 2)
        XCTAssertTrue(world.deadCells.count == 98)
    }
    
    func testLivingNeighboursSearch() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        world[0,1]?.isAlive = true
        world[1,0]?.isAlive = true
        
        XCTAssertTrue(world.aliveNeighbourCountAt(Position(x: 0, y: 0)) == 2)
        XCTAssertTrue(world.aliveNeighbourCountAt(Position(x: 1, y: 1)) == 2)
        XCTAssertTrue(world.aliveNeighbourCountAt(Position(x: 0, y: 1)) == 1)
        XCTAssertTrue(world.aliveNeighbourCountAt(Position(x: 2, y: 2)) == 0)
    }
    
    func testDyingCells() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        world[0,1]?.isAlive = true
        world[1,0]?.isAlive = true
        
        world[4,4]?.isAlive = true
        world[4,5]?.isAlive = true
        world[5,4]?.isAlive = true
        
        XCTAssertTrue(world.dyingCells().count == 2)
    }
    
    func testRevivingCells() {
        let world = WorldViewModel(dimensions: 10, isEmpty: true)
        world[4,4]?.isAlive = true
        world[4,5]?.isAlive = true
        world[5,4]?.isAlive = true
        world[4,3]?.isAlive = true
        
        XCTAssertTrue(world.revivingCells().count == 3)
    }
    
    func testPerfomanceUnoptimised() {
        let world = WorldViewModel(dimensions: 100)
        measure {
            for _ in 0...2 {
                world.tick()
            }
        }
    }
}
