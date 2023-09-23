//
//  DrawingView.swift
//  kata (iOS)
//
//  Created by Evgeny Mikhalkov on 2023-09-23.
//

import SwiftUI

struct DrawingView: UIViewRepresentable {
    @EnvironmentObject var world: WorldViewModel
    private let view = UIView()
    private var layerCell = LayerCell()

    var layer: CALayer? {
        view.layer
    }
    
    func build() {
        view.backgroundColor = .black
        for x in 0..<world.dimensions {
            for y in 0..<world.dimensions {
                let cellViewModel = world[x, y]
                if let l2: CALayer = layerCell[x, y] {
                    l2.backgroundColor = cellViewModel?.color.uiColor.cgColor
                } else {
                    let itemSize: Double = 2.0
                    let l1 = CALayer()
                    l1.backgroundColor = cellViewModel?.color.uiColor.cgColor
                    l1.frame = CGRect(
                        x: itemSize * Double(x),
                        y: itemSize * Double(y),
                        width: itemSize,
                        height: itemSize
                    )
                    layerCell[x, y] = l1
                    layer?.addSublayer(l1)
                }
            }
        }
    }

    func makeUIView(context: Context) -> UIView {
        build()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        build()
    }
}
