//
//  kataApp.swift
//  Shared
//
//  Created by Evgeny Mikhalkov on 2022-09-12.
//

import SwiftUI

@main
struct kataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(World(dimensions: 100))
        }
    }
}

