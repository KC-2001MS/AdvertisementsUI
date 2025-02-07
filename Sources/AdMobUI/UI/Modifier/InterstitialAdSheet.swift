//
//  InterstitialAdSheet.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/05.
//

import SwiftUI

@available(iOS 17.0, *)
public struct InterstitialAdSheetModifier: ViewModifier {
    @Binding private var isPresented: Bool
    
    @State private var interstitialAdManager = InterstitialAdManager()

    public init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    public func body(content: Content) -> some View {
        content
            .task(id: isPresented) {
                await interstitialAdManager.loadAd()
                if isPresented {
                    interstitialAdManager.showAd()
                }
            }
            .onDisappear {
                isPresented = false
            }
    }
}

@available(iOS 17.0, *)
extension View {
    public func interstitialAdSheet(isPresented: Binding<Bool>) -> some View {
        self.modifier(InterstitialAdSheetModifier(isPresented: isPresented))
    }
}
