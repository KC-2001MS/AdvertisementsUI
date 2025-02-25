//
//  RewardedInterstitialAdSheet.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//

#if canImport(GoogleMobileAds)
import SwiftUI

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct RewardedInterstitialAdSheetModifier: ViewModifier {
    @Binding private var isPresented: Bool
    
    @State private var rewardedInterstitialAdManager = RewardedInterstitialAdManager()
    
    var completionAction: () -> Void

    init(
        isPresented: Binding<Bool>,
        completionAction: @escaping () -> Void
    ) {
        self._isPresented = isPresented
        self.completionAction = completionAction
    }

    func body(content: Content) -> some View {
        content
            .task(id: isPresented) {
                await rewardedInterstitialAdManager.loadAd()
                if isPresented {
                    rewardedInterstitialAdManager
                        .showAd(completionAction: completionAction())
                }
            }
            .onDisappear {
                isPresented = false
            }
    }
}

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension View {
    /// Modifier to display rewarded interstitial ads
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - completionAction: Actions that define the reward after displaying an ad
    /// - Returns: View that displays ads when the variable passed to isPresented is true
    public func rewardedInterstitialAdSheet(
        isPresented: Binding<Bool>,
        completionAction: @escaping () -> Void
    ) -> some View {
        self.modifier(
            RewardedInterstitialAdSheetModifier(
                isPresented: isPresented,
                completionAction: completionAction
            )
        )
    }
}

#Preview {
    Text("Rewarded Interstitial Ad")
        .rewardedInterstitialAdSheet(isPresented: .constant(true)) {
            
        }
        .admobContainer()
}
#endif
