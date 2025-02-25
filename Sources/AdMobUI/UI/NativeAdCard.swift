//
//  NativeAd.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/05.
//

#if canImport(GoogleMobileAds)
@preconcurrency import GoogleMobileAds
import SwiftUI

/// Class to control the display of native ads
@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@Observable
final class NativeAdManager: NSObject, @preconcurrency NativeAdLoaderDelegate {
    var nativeAd: NativeAd?
    var adLoader: AdLoader?
    
    var key: String
    
    init(key: String? = nil) {
        self.key = key ?? "Native"
    }

    /// Function to load ads
    func loadAd() {
        let request = Request()
        if let id = adUnitID(key: key) {
            adLoader = AdLoader(
                adUnitID: id,
                rootViewController: nil,
                adTypes: [.native],
                options: nil
            )
        }
        else {
            adLoader = AdLoader(
                adUnitID: "ca-app-pub-3940256099942544/3986624511",
                rootViewController: nil,
                adTypes: [.native],
                options: nil
            )
        }
        
        adLoader?.delegate = self
        adLoader?.load(request)
    }

    @MainActor
    func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        self.nativeAd = nativeAd
    }

    @MainActor
    func adLoader(
        _ adLoader: AdLoader,
        didFailToReceiveAdWithError error: Error
    ) {
    }
    
    func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
}

/// View to display native ads
@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct NativeAdCard<Style: NativeAdStyle>: View {
    @State private var nativeAdManager: NativeAdManager
    
    var key: String?
    
    var style: Style

    public init(key: String? = nil) where Style == DefaultNativeAdStyle {
        self.key = key
        self.style = DefaultNativeAdStyle()
        self.nativeAdManager = NativeAdManager(key: key)
    }
    
    init(key: String? = nil, style: Style) {
        self.style = style
        self.nativeAdManager = NativeAdManager(key: key)
    }
    
    public var body: some View {
        style
            .makeBody(
                configuration: NativeAdStyleConfiguration(
                    nativeAd: nativeAdManager.nativeAd
                )
            )
            .alignmentGuide(.listRowSeparatorLeading) { _ in  0 }
            .task {
                nativeAdManager.loadAd()
            }
    }
}

@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
extension NativeAdCard {
    public func nativeAdStyle<S>(_ style: S) -> some View where S: NativeAdStyle {
        return NativeAdCard<S>(key: key, style: style)
    }
}

#Preview {
    NativeAdCard()
        .admobContainer()
}
#endif
