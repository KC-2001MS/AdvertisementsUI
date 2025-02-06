// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import GoogleMobileAds

// バナー表示用のクラス
@available(iOS 17.0, *)
public struct AdBanner: UIViewRepresentable {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    public init() {}
    
    public func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        if let id = adUnitID(key: "Banner") {
            banner.adUnitID = id
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            banner.rootViewController = windowScene?.keyWindow?.rootViewController
            let request = GADRequest()
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            banner.load(request)
        }
        return banner
    }
    
    func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
 
    public func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}
