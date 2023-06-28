//
//  ContentView.swift
//  Shared
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var world: World
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let drawingView = DrawingView()
    
    var body: some View {
        GeometryReader { layout in
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<world.dimensions, id: \.self) { x in
                    GridRow{
                        ForEach(0..<world.dimensions, id: \.self) { y in
                            Rectangle()
                                .fill((world[x,y]?.isAlive ?? false) ? .green : .gray)
                                .frame(
                                    width: (layout.size.width * 0.9) / (CGFloat(world.dimensions)),
                                    height: (layout.size.width * 0.9) / (CGFloat(world.dimensions))
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .onReceive(timer) { input in
            world.tick()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(World(dimensions: 60))
    }
}

struct DrawingView: UIViewRepresentable {
    @EnvironmentObject var world: World
    private let view = UIView()
    private var layerCell = LayerCell( )

    var layer: CALayer? {
        view.layer
    }
    
    func build() {
        view.backgroundColor = .black
        for x in 0..<world.dimensions {
            for y in 0..<world.dimensions {
                if let l2: CALayer = layerCell[x, y] {
                    l2.backgroundColor = (world[x, y]?.isAlive ?? false) ? UIColor.green.cgColor : UIColor.gray.cgColor
                } else {
                    let itemSize: Double = 2.0
                    let l1 = CALayer()
                    l1.backgroundColor = (world[x, y]?.isAlive ?? false) ? UIColor.green.cgColor : UIColor.gray.cgColor
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
        view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        build()
    }
}
