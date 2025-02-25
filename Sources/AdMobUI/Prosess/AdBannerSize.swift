//
//  AdBannerSize.swift
//  AdvertisementsUI
//
//  Created by 茅根啓介 on 2025/02/21.
//

#if canImport(GoogleMobileAds)
import GoogleMobileAds
import SwiftUICore

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AdBannerSize: Sendable {
    var size: AdSize
    
    var verticalEdge: VerticalEdge
    
    var isOllapsible: Bool
    
    init(size: AdSize, edge: VerticalEdge? = nil, isOllapsible: Bool = false) {
        self.size = size
        self.verticalEdge = edge ?? .bottom
        self.isOllapsible = isOllapsible
    }
    
    init(width: CGFloat) {
        self.size = currentOrientationAnchoredAdaptiveBanner(width: width)
        self.verticalEdge = .bottom
        self.isOllapsible = false
    }
    
    public static let fixedBanner: AdBannerSize = .init(size: AdSizeBanner)
    
    public static let fixedLargeBanner: AdBannerSize = .init(
        size: AdSizeLargeBanner
    )
    
    public static let fixedIABMediumRectangle: AdBannerSize = .init(
        size: AdSizeMediumRectangle
    )
    
    public static let fixedIABFullSizeBanner: AdBannerSize = .init(
        size: AdSizeFullBanner
    )
    
    public static let fixedIABLeaderboard: AdBannerSize = .init(
        size: AdSizeLeaderboard
    )
    
    public static func smart(width: CGFloat) -> AdBannerSize {
        return .init(
            size: currentOrientationAnchoredAdaptiveBanner(width: width)
        )
    }
    
    public static func inlineAdaptive(width: CGFloat) -> AdBannerSize {
        return .init(size: currentOrientationInlineAdaptiveBanner(width: width))
    }
    
    public static func ollapsible(width: CGFloat, edge: VerticalEdge) -> AdBannerSize {
        return .init(
            size: currentOrientationAnchoredAdaptiveBanner(width: width),
            edge: edge,
            isOllapsible: true
        )
    }
    
    public static func custom(width: CGFloat, height: CGFloat) -> AdBannerSize {
        return .init(
            size: adSizeFor(cgSize: CGSize(width: width, height: height))
        )
    }
}
#endif
