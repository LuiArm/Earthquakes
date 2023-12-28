//
//  EarthquakesApp.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/7/23.
//

import SwiftUI

@main
struct EarthquakesApp: App {
    @StateObject var quakesProvider = QuakesProvider()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(quakesProvider)//pass property to view environement
        }
    }
}
