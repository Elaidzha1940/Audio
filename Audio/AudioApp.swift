//  /*
//
//  Project: Audio
//  File: AudioApp.swift
//  Created by: Elaidzha Shchukin
//  Date: 14.08.2023
//
//  Status: in progress | Decorated
//
//  */

import SwiftUI

@main
struct AudioApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
                .preferredColorScheme(.dark)
        }
    }
}
