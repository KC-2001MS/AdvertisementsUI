//
//  SampleApp.swift
//  Sample
//
//  Created by 茅根啓介 on 2025/02/03.
//

import SwiftUI
import AdMobUI
import AppLovinSDK

@main
struct SampleApp: App {
    init() {
        let initConfig = ALSdkInitializationConfiguration(sdkKey: "YOUR_SDK_KEY") { builder in
              builder.mediationProvider = ALMediationProviderMAX
          }
          
          // SDK を初期化
          ALSdk.shared().initialize(with: initConfig) { sdkConfig in
              print("AppLovin SDK Initialized")
          }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .admobContainer()
    }
}
