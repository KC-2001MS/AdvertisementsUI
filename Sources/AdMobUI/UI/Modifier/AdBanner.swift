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
    
    let edge: VerticalEdge
    
    init(isPresented: Binding<Bool>, edge: VerticalEdge? = nil) {
        self._isPresented = isPresented
        self.edge = edge ?? .bottom
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(
                edge: adBannerSize?.isOllapsible == true ? (
                    adBannerSize?.verticalEdge == .top ? .top : .bottom
                ) : edge
            ) {
                if isPresented {
                    AdBannerCard()
                        .frame(maxHeight: adBannerSize?.size.size.height ?? 250)
                }
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
    public func adBanner(isPresented: Binding<Bool>, edge: VerticalEdge? = nil) -> some View {
        self.modifier(AdBannerModifier(isPresented: isPresented, edge: edge))
    }
    
    public func adBanner(_  hiden: Bool, edge: VerticalEdge? = nil) -> some View {
        self.modifier(
            AdBannerModifier(isPresented: .constant(!hiden), edge: edge)
        )
    }
}
#endif
