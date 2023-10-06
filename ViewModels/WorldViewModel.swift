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
        //let res = numIdenticalPairs([1,1,1,1])
        //let res = majorityElement([1,2])
//        let res = integerBreak(10)
//        print()
    }
    
    func integerBreak(_ n: Int) -> Int {
        var num = n
        if num <= 3 {
            return num - 1
        }
        
        var result = 1
        
        while (num > 4) {
            result *= 3
            num -= 3
        }
        
        return result * num
    }
    
    func majorityElement(_ nums: [Int]) -> [Int] {
        let countMin = abs(nums.count / 3)
        var result: [Int] = []
        var count = 0
        var prev = -1
        for num in nums.sorted(by: { $0 > $1 }) {
            if num != prev {
                count = 0
            }
            
            if count >= countMin {
                if !result.contains(num) {
                    result.append(num)
                }
            }
            
            prev = num
            count += 1
        }
        
        return result
    }
    
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var i = 0
        var pairCounter = 0
        var length = nums.count
        for iValue in nums {
            for j in min(i+1, length-1)...length-1 {
                let jVal = nums[j]
                
                if i < j, iValue == jVal {
                    pairCounter += 1
                }
            }
            
            i += 1
        }
        
        return pairCounter
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

//class MyHashMap {
//    var storage: [Int]
//
//    init() {
//        storage = Array(repeating: -1, count: 1000001)
//    }
//
//    func put(_ key: Int, _ value: Int) {
//        storage[key] = value
//    }
//
//    func get(_ key: Int) -> Int {
//        storage[key]
//    }
//
//    func remove(_ key: Int) {
//        storage[key] = -1
//    }
//}





//struct ListNode {
//    var key = -1
//    var value = -1
//}

//class MyHashMap {
//    private var buckets: [[ListNode]]
//    private let bucketSize: Int
//
//    init(bucketSize: Int = 10000) {
//        self.bucketSize = bucketSize
//        self.buckets = Array(repeating: [ListNode](), count: bucketSize)
//    }
//
//    func hash(_ key: Int) -> Int {
//        key % bucketSize
//    }
//
//    func put(_ key: Int, _ value: Int) {
//        if let existingIndex = index(key) {
//            // update value
//            buckets[hash(key)][existingIndex].value = value
//        }
//        else {
//            // insert
//            buckets[hash(key)].append(ListNode(key: key, value: value))
//        }
//    }
//
//    func get(_ key: Int) -> Int {
//        // Check if existing index exists
//        guard let existingIndex = index(key) else { return -1 }
//        return buckets[hash(key)][existingIndex].value
//    }
//
//    func remove(_ key: Int) {
//        guard let existingIndex = index(key) else { return }
//
//        buckets[hash(key)].remove(at: existingIndex)
//    }
//
//    private func index(_ key: Int) -> Int? {
//        buckets[hash(key)].firstIndex { $0.key == key }
//    }
//}

