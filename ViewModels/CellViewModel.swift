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
        cell.isAlive
    }
    
    var color: Color {
        isAlive ? .green : .gray
    }
}
