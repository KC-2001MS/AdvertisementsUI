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
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@Observable
public final class NativeAdManager: NSObject,  @preconcurrency NativeAdLoaderDelegate {
    public var nativeAd: NativeAd?
    private var adLoader: AdLoader?

    private var key: String
    
    public init(key: String? = nil) {
        self.key = key ?? "Native"
    }

    /// Function to load ads
    public func loadAd() {
        let request = Request()
        if let id = adUnitID(key: key) {
            adLoader = AdLoader(
                adUnitID: id,
                rootViewController: nil,
                adTypes: [.native],
                options: nil
            )
            adLoader?.delegate = self
            adLoader?.load(request)
        }
    }

    @MainActor
    public func adLoader(_ adLoader: AdLoader, didReceive nativeAd: NativeAd) {
        self.nativeAd = nativeAd
    }

    @MainActor
    public func adLoader(_ adLoader: AdLoader, didFailToReceiveAdWithError error: Error) {
    }
    
    private func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
}

/// View to display native ads
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct NativeAdCard: View {
    var nativeAd: NativeAd
    
    /// Create a view to display a native ad.
    public init(nativeAd: NativeAd) {
        self.nativeAd = nativeAd
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
//            if let ad = nativeAd {
                if let icon = nativeAd.icon, let image = icon.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Text(nativeAd.headline ?? "広告タイトル")
                    .font(.headline)
                
                if let advertiser = nativeAd.advertiser {
                    Text(advertiser)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Button(action: {
                }) {
                    Text(nativeAd.callToAction ?? "詳細を見る")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
//            } else {
//                ProgressView()
//            }
        }
        .padding()
    }
}
#endif
