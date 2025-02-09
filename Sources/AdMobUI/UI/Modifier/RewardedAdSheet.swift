//
//  RewardedAdSheet.swift
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
struct RewardedAdSheetModifier: ViewModifier {
    @Binding private var isPresented: Bool
    
    @State private var rewardedAdManager = RewardedAdManager()
    
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
                await rewardedAdManager.loadAd()
                if isPresented {
                    rewardedAdManager.showAd(completionAction: completionAction())
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
    /// Modifier to display rewarded ads
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - completionAction: Actions that define the reward after displaying an ad
    /// - Returns: View that displays ads when the variable passed to isPresented is true
    public func rewardedAdSheet(
        isPresented: Binding<Bool>,
        completionAction: @escaping () -> Void
    ) -> some View {
        self.modifier(RewardedAdSheetModifier(isPresented: isPresented, completionAction: completionAction))
    }
}
#endif
