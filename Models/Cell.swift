//
//  Cell.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import UIKit

 class Cell: StatefullCell {
     var position: Position
     var state: CellState
    
     init(position: Position, state: CellState) {
         self.position = position
         self.state = state
     }
    
     var isAlive: Bool {
         get {
             state == .alive
         }
        
         set {
             state = newValue ? .alive : .dead
         }
     }
    
     func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
     }
    
     static func == (lhs: Cell, rhs: Cell) -> Bool {
         lhs.position == rhs.position && lhs.state == rhs.state && lhs.isAlive == rhs.isAlive
     }
 }
