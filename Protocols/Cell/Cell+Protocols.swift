//
//  Cell+Protocols.swift
//  kata
//
//  Created by Evgeny Mikhalkov on 2022-09-14.
//

import Foundation

protocol BaseCell: AnyObject, Equatable, Hashable {
    var position: Position { get set }
}

protocol StatefullCell: BaseCell {
    var state: CellState { get set }
    var isAlive: Bool { get set }
}
