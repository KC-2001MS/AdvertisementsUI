//
//  NativeAd.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/05.
//

@preconcurrency import GoogleMobileAds
import SwiftUI

@available(iOS 17.0, *)
@Observable
public final class NativeAdManager: NSObject,  @preconcurrency GADNativeAdLoaderDelegate {
    public var nativeAd: GADNativeAd?
    private var adLoader: GADAdLoader?
    
    var action: () -> () = {}

    public func loadAd() {
        let request = GADRequest()
        if let id = adUnitID(key: "Native") {
            adLoader = GADAdLoader(
                adUnitID: id,
                rootViewController: nil,
                adTypes: [.native],
                options: nil
            )
            adLoader?.delegate = self
            adLoader?.load(request)
        }
    }
    /// ネイティブ広告の取得成功時に呼ばれる
    @MainActor
    public func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        print("✅ ネイティブ広告が読み込まれました")
        self.nativeAd = nativeAd
    }
    /// ネイティブ広告の取得失敗時に呼ばれる
    @MainActor
    public func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print("❌ ネイティブ広告のロード失敗: \(error.localizedDescription)")
    }
    
    func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
}

@available(iOS 17.0, *)
public struct NativeAdCard: View {
    var nativeAd: GADNativeAd
    
    public init(nativeAd: GADNativeAd) {
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

