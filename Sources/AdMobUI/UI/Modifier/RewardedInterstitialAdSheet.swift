//
//  RewardedInterstitialAdSheet.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//

import SwiftUI

@available(iOS 17.0, *)
public struct RewardedInterstitialAdSheetModifier: ViewModifier {
    @Binding private var isPresented: Bool
    
    @State private var rewardedInterstitialAdManager = RewardedInterstitialAdManager()
    
    private var completionAction: () -> Void

    public init(
        isPresented: Binding<Bool>,
        completionAction: @escaping () -> Void
    ) {
        self._isPresented = isPresented
        self.completionAction = completionAction
    }

    public func body(content: Content) -> some View {
        content
            .task(id: isPresented) {
                await rewardedInterstitialAdManager.loadAd()
                if isPresented {
                    rewardedInterstitialAdManager.showAd(completionAction: completionAction())
                }
            }
            .onDisappear {
                isPresented = false
            }
    }
}

@available(iOS 17.0, *)
extension View {
    public func rewardedInterstitialAdSheetSheet(
        isPresented: Binding<Bool>,
        completionAction: @escaping () -> Void
    ) -> some View {
        self.modifier(RewardedInterstitialAdSheetModifier(isPresented: isPresented, completionAction: completionAction))
    }
}
