//
//  ContentView.swift
//  Shared
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var world: WorldViewModel
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let drawingView = DrawingView()
    
    var body: some View {
        GeometryReader { layout in
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<world.dimensions, id: \.self) { x in
                    GridRow {
                        ForEach(0..<world.dimensions, id: \.self) { y in
                            Rectangle()
                                .fill(world[x, y]?.color ?? .gray)
                                .frame(
                                    width: (layout.size.width * 0.9) / CGFloat(world.dimensions),
                                    height: (layout.size.width * 0.9) / CGFloat(world.dimensions)
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
        ContentView().environmentObject(WorldViewModel(dimensions: 60))
    }
}
