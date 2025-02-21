//
//  AdBanner.swift
//  AdvertisementsUI
//
//  Created by 茅根啓介 on 2025/02/21.
//

#if canImport(GoogleMobileAds)
import SwiftUI

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct AdBannerModifier: ViewModifier {
    @Environment(\.adBannerSize) private var adBannerSize
    
    @State private var viewSize: CGSize = .zero
    
    @Binding private var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                if isPresented {
                    AdBannerCard()
//                        .frame(maxHeight: adBannerSize?.size.size.height ?? .infinity)
                }
            }
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .onChange(of: geometry.size, initial: true) {
                            viewSize = geometry.size
                        }
                }
            )
//            .environment(\.adBannerSize, adBannerSize == nil ? AdBannerSize(width: viewSize.width) : adBannerSize)
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
    public func adBanner(isPresented: Binding<Bool>) -> some View {
        self.modifier(AdBannerModifier(isPresented: isPresented))
    }
}
#endif
