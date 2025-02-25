//
//  AdBannerSize.swift
//  AdvertisementsUI
//
//  Created by 茅根啓介 on 2025/02/24.
//

#if canImport(GoogleMobileAds)
import SwiftUI

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct AdBannersSizeModifier: ViewModifier {
    @Environment(\.adBannerSize) private var adBannerSize
    
    private var size: AdBannerSize
    
    init(size: AdBannerSize) {
        self.size = size
    }

    func body(content: Content) -> some View {
        content
            .environment(\.adBannerSize, size)
    }
}

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension View {
    public func adBannersSize(_ size: AdBannerSize) -> some View {
        self.modifier(AdBannersSizeModifier(size: size))
    }
}
#endif
