//
//  iAd.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/04.
//
#if canImport(GoogleMobileAds)
import SwiftUI
@preconcurrency import GoogleMobileAds


@available(iOS 17.0, *)
@Observable
public final class InterstitialAdManager: NSObject, FullScreenContentDelegate {
    private var interstitial: InterstitialAd?
    
    @MainActor
    public func loadAd() async {
        do {
            if let id = adUnitID(key: "Interstitial") {
                self.interstitial = try await InterstitialAd.load(with: id, request: Request())
                self.interstitial?.fullScreenContentDelegate = self
            }
        } catch {
          print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
      }

    @MainActor
    public func showAd() {
        guard let _ = interstitial, let ad = interstitial,
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
              let rootViewController = keyWindow.rootViewController else {
            print("広告が準備できていません")
            return
        }
        
        ad.present(from: rootViewController)
    }
    
    
    func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
    
//    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
//      print("\(#function) called")
//    }
//
//    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
//      print("\(#function) called")
//    }
//
//    func ad(
//      _ ad: GADFullScreenPresentingAd,
//      didFailToPresentFullScreenContentWithError error: Error
//    ) {
//      print("\(#function) called")
//    }
//
//    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//      print("\(#function) called")
//    }
//
//    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//      print("\(#function) called")
//    }
//
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//      print("\(#function) called")
//      // Clear the interstitial ad.
//      interstitial = nil
//    }
}
#endif
