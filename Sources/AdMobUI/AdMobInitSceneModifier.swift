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
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension Scene {
    /// Modifier to configure AdMob display
    public func admobContainer() -> some Scene {
        MobileAds.shared.start(completionHandler: nil)
        return self
    }
}
#endif
