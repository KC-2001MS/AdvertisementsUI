//
//  RewardedInterstitialAdManager.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//

#if canImport(GoogleMobileAds)
@preconcurrency import GoogleMobileAds
import Observation

/// Class to control the display of rewarded interstitial ads
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@Observable
public final class RewardedInterstitialAdManager: NSObject, FullScreenContentDelegate {
    private var rewardedInterstitialAd: RewardedInterstitialAd?
    
    private var key: String
    
    public init(key: String? = nil) {
        self.key = key ?? "RewardedInterstitial"
    }
    /// Function to load ads
    @MainActor
    public func loadAd() async {
        do {
            if let id = adUnitID(key: key) {
                rewardedInterstitialAd = try await RewardedInterstitialAd.load(
                    with: id, request: Request())
                rewardedInterstitialAd?.fullScreenContentDelegate = self
            }
        } catch {
            print(
                "Failed to load rewarded interstitial ad with error: \(error.localizedDescription)")
        }
    }
    
    /// Functions for displaying ads
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
    
    private func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
}
#endif
