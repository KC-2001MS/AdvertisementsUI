// The Swift Programming Language
// https://docs.swift.org/swift-book
#if canImport(GoogleMobileAds)
import SwiftUI
import GoogleMobileAds

/// View to display banner ads
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AdBanner: UIViewRepresentable {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    /// Create a view to display a banner ad.
    public init() {}
    
    public func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: AdSizeBanner)
        if let id = adUnitID(key: "Banner") {
            banner.adUnitID = id
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            banner.rootViewController = windowScene?.keyWindow?.rootViewController
            let request = Request()
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            banner.load(request)
        }
        return banner
    }
    
    private func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
 
    public func updateUIView(_ uiView: BannerView, context: Context) {
    }
}
#endif
