//
//  RewardedInterstitialAdManager.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//

#if canImport(GoogleMobileAds)
@preconcurrency import GoogleMobileAds
import Observation

@Observable
public final class RewardedInterstitialAdManager: NSObject, FullScreenContentDelegate {
    private var rewardedInterstitialAd: RewardedInterstitialAd?
    
    @MainActor
    public func loadAd() async {
        do {
            if let id = adUnitID(key: "RewardedInterstitial") {
                rewardedInterstitialAd = try await RewardedInterstitialAd.load(
                    with: id, request: Request())
                rewardedInterstitialAd?.fullScreenContentDelegate = self
            }
        } catch {
            print(
                "Failed to load rewarded interstitial ad with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    public func showAd(completionAction: @autoclosure @escaping () -> Void) {
        guard let rewardedInterstitialAd = rewardedInterstitialAd else {
            return print("Ad wasn't ready.")
        }
        
        rewardedInterstitialAd.present(from: nil) {
            let reward = rewardedInterstitialAd.adReward
            print("Reward amount: \(reward.amount)")
            completionAction()
        }
    }
    
    public func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
    
//    public func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    public func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    public func ad(
//        _ ad: GADFullScreenPresentingAd,
//        didFailToPresentFullScreenContentWithError error: Error
//    ) {
//        print("\(#function) called")
//    }
//    
//    public func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    public func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//        // Clear the rewarded interstitial ad.
//        rewardedInterstitialAd = nil
//    }
}
#endif
