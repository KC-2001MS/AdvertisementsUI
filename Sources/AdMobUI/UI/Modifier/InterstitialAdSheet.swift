//
//  InterstitialAdSheet.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/05.
//

#if canImport(GoogleMobileAds)
import SwiftUI

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct InterstitialAdSheetModifier: ViewModifier {
    @Binding private var isPresented: Bool
    
    @State private var interstitialAdManager = InterstitialAdManager()

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    func body(content: Content) -> some View {
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
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension View {
    /// Modifier to display interstitial ads
    /// - Parameter isPresented: A binding to a Boolean value that determines whether to present the sheet that you create in the modifier’s content closure.
    /// - Returns: View that displays ads when the variable passed to isPresented is true
    public func interstitialAdSheet(isPresented: Binding<Bool>) -> some View {
        self.modifier(InterstitialAdSheetModifier(isPresented: isPresented))
    }
}

#Preview {
    Text("Interstitial Ad")
        .interstitialAdSheet(isPresented: .constant(true))
        .admobContainer()
}
#endif
