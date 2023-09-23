//
//  CellViewModel.swift
//  kata (iOS)
//
//  Created by Evgeny Mikhalkov on 2023-09-23.
//

import SwiftUI

class CellViewModel: ObservableObject {
    @Published private var cell: Cell
    var position: Position {
        cell.position
    }
    
    init(cell: Cell) {
        self.cell = cell
    }
    
    var isAlive: Bool {
        get {
            cell.isAlive
        }
        set {
            cell.state = newValue ? .alive : .dead
        }
    }
    
    var color: Color {
        isAlive ? .green : .gray
    }
}
