//
//  iAd.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/04.
//
#if canImport(GoogleMobileAds)
import SwiftUI
@preconcurrency import GoogleMobileAds

/// Class to control the display of interstitial ads
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@Observable
public final class InterstitialAdManager: NSObject, FullScreenContentDelegate {
    private var interstitial: InterstitialAd?
    
    private var key: String
    
    public init(key: String? = nil) {
        self.key = key ?? "Interstitial"
    }
    
    /// Function to load ads
    @MainActor
    public func loadAd() async {
        do {
            if let id = adUnitID(key: key) {
                self.interstitial = try await InterstitialAd
                    .load(with: id, request: Request())
                self.interstitial?.fullScreenContentDelegate = self
            }
        } catch {
            print(
                "Failed to load interstitial ad with error: \(error.localizedDescription)"
            )
        }
    }

    /// Functions for displaying ads
    @MainActor
    public func showAd() {
        guard let _ = interstitial, let ad = interstitial,
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(
                where: { $0.isKeyWindow
                }),
              let rootViewController = keyWindow.rootViewController else {
            print("広告が準備できていません")
            return
        }
        
        ad.present(from: rootViewController)
    }
    
    
    private func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
}
#endif
