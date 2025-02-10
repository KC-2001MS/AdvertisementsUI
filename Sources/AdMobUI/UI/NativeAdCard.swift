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
final class NativeAdManager: NSObject,  @preconcurrency NativeAdLoaderDelegate {
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
            adLoader?.delegate = self
            adLoader?.load(request)
        }
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
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct NativeAdCard: View {
    @State private var nativeAdManager: NativeAdManager
    
    public init(key: String? = nil) {
        self.nativeAdManager = NativeAdManager(key: "Native")
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 8) {
                Image(
                    uiImage: nativeAdManager.nativeAd?.icon?.image ?? UIImage()
                )
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(nativeAdManager.nativeAd?.headline ?? "")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .lineLimit(2)
            }

            Text(nativeAdManager.nativeAd?.advertiser ?? "")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
            
            if let callToAction = nativeAdManager.nativeAd?.callToAction {
                Button {
                } label: {
                    Text(callToAction)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            } else {
                Spacer()
                    .frame(height: 50)
            }
        }
        .padding(5)
        .frame(maxWidth: .infinity)
        .task {
            nativeAdManager.loadAd()
        }
        .overlay {
            if nativeAdManager.nativeAd == nil {
                ProgressView()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
            }
        }
}
}
#endif
