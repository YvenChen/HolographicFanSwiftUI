//
//  HolographicFanSwiftUIApp.swift
//  HolographicFanSwiftUI
//
//  Created by Yven Chen on 2023/4/6.
//

import SwiftUI

@main
struct HolographicFanSwiftUIApp: App {
    @StateObject var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
