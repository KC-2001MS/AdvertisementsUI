//
//  RewardedAdManager.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//
#if canImport(GoogleMobileAds)
@preconcurrency import GoogleMobileAds
import Observation

/// Class to control the display of rewarded ads
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@Observable
public final class RewardedAdManager: NSObject, FullScreenContentDelegate {
    private var rewardedAd: RewardedAd?
    
    private var key: String
    
    public init(key: String? = nil) {
        self.key = key ?? "Rewarded"
    }
    
    /// Function to load ads
    @MainActor
    public func loadAd() async {
        do {
            if let id = adUnitID(key: key) {
                rewardedAd = try await RewardedAd.load(
                    with: id, request: Request())
                rewardedAd?.fullScreenContentDelegate = self
            }
        } catch {
            print(
                "Failed to load rewarded ad with error: \(error.localizedDescription)"
            )
        }
    }
    
    /// Functions for displaying ads
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
    
    private func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
}
#endif
