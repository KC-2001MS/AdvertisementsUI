//
//  AdMobInitSceneModifier.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/07.
//

#if canImport(GoogleMobileAds)
import SwiftUI
import GoogleMobileAds

@available(iOS 17.0, *)
extension Scene {
    public func admobContainer() -> some Scene {
        MobileAds.shared.start(completionHandler: nil)
        return self
    }
}
#endif
