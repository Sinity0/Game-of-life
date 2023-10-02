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
    
    var body: some View {
        DrawingView(image: world.drawWorldToImage(world: world.world))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
