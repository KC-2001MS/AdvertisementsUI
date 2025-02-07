//
//  AdMobInitSceneModifier.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/07.
//

import SwiftUI
import GoogleMobileAds

extension Scene {
    public func admobContainer() -> some Scene {
        MobileAds.shared.start(completionHandler: nil)
        return self
    }
}
