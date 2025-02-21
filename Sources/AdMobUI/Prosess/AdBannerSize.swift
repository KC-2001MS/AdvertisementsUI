//
//  AdBannerSize.swift
//  AdvertisementsUI
//
//  Created by 茅根啓介 on 2025/02/21.
//

#if canImport(GoogleMobileAds)
import GoogleMobileAds

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AdBannerSize: Sendable {
    var size: AdSize
    
    var alignment: AdBannerAlignment?
    
    init(size: AdSize, alignment: AdBannerAlignment? = nil) {
        self.size = size
        self.alignment = alignment
    }
    
    init(width: CGFloat) {
        self.size = currentOrientationAnchoredAdaptiveBanner(width: width)
        self.alignment = nil
    }
    
    public static let fixedBanner: AdBannerSize = .init(size: AdSizeBanner)
    
    public static let fixedLargeBanner: AdBannerSize = .init(size: AdSizeLargeBanner)
    
    public static let fixedIABMediumRectangle: AdBannerSize = .init(size: AdSizeMediumRectangle)
    
    public static let fixedIABFullSizeBanner: AdBannerSize = .init(size: AdSizeFullBanner)
    
    public static let fixedIABLeaderboard: AdBannerSize = .init(size: AdSizeLeaderboard)
    
    public static func smart(width: CGFloat) -> AdBannerSize {
        return .init(size: currentOrientationAnchoredAdaptiveBanner(width: width))
    }
    
    public static func inlineAdaptive(width: CGFloat) -> AdBannerSize {
        return .init(size: currentOrientationInlineAdaptiveBanner(width: width))
    }
    
    public static func ollapsible(width: CGFloat, alignment: AdBannerAlignment) -> AdBannerSize {
        return .init(size: currentOrientationAnchoredAdaptiveBanner(width: width), alignment: alignment)
    }
    
    public static func custom(width: CGFloat, height: CGFloat) -> AdBannerSize {
        return .init(size: adSizeFor(cgSize: CGSize(width: width, height: height)))
    }
}
#endif
