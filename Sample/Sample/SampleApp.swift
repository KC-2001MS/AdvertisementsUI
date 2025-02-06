//
//  SampleApp.swift
//  Sample
//
//  Created by 茅根啓介 on 2025/02/03.
//

import SwiftUI
import AdMobAdsUI

@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .admobContainer()
    }
}
