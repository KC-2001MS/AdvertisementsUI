//
//  RewardedAdSheet.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//

import SwiftUI

@available(iOS 17.0, *)
public struct RewardedAdSheetModifier: ViewModifier {
    @Binding private var isPresented: Bool
    
    @State private var rewardedAdManager = RewardedAdManager()
    
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
extension View {
    public func rewardedAdSheetSheet(
        isPresented: Binding<Bool>,
        completionAction: @escaping () -> Void
    ) -> some View {
        self.modifier(RewardedAdSheetModifier(isPresented: isPresented, completionAction: completionAction))
    }
}
