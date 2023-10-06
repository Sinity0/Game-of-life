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
            ContentView().environmentObject(WorldViewModel(dimensions: 100))
        }
    }
}

