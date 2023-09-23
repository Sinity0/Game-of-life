//
//  Array+Action.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-13.
//

import Foundation

extension Array where Element == Cell {
    func each (action: (Cell) -> ()) {
        forEach { action($0) }
    }
}
