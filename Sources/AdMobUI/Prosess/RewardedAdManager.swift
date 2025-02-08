//
//  RewardedAdManager.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//
#if canImport(GoogleMobileAds)
@preconcurrency import GoogleMobileAds
import Observation

@Observable
public final class RewardedAdManager: NSObject, FullScreenContentDelegate {
    private var rewardedAd: RewardedAd?
    
    @MainActor
    public func loadAd() async {
        do {
            if let id = adUnitID(key: "Rewarded") {
                rewardedAd = try await RewardedAd.load(
                    with: id, request: Request())
                rewardedAd?.fullScreenContentDelegate = self
            }
        } catch {
            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    public func showAd(completionAction: @autoclosure @escaping () -> Void) {
      guard let rewardedAd = rewardedAd else {
        return print("Ad wasn't ready.")
      }

        rewardedAd.present(from: nil) {
        let reward = rewardedAd.adReward
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
//        // Clear the rewarded ad.
//        rewardedAd = nil
//    }
}
#endif
