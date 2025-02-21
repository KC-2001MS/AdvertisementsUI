// The Swift Programming Language
// https://docs.swift.org/swift-book
#if canImport(GoogleMobileAds)
import SwiftUI
import GoogleMobileAds

struct AdBannerCardInternal: UIViewRepresentable {
    var adBannerSize: AdBannerSize
    /// Create a view to display a banner ad.
    init(adBannerSize: AdBannerSize) {
        self.adBannerSize = adBannerSize
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(
            adSize: adBannerSize.size
        )
        if let id = adUnitID(key: "Banner") {
            banner.adUnitID = id
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            banner.rootViewController = windowScene?.keyWindow?.rootViewController
            let request = Request()
            
            if let alignment = adBannerSize.alignment {
                let extras = Extras()
                extras.additionalParameters = ["collapsible" : alignment.rawValue]
                request.register(extras)
            }
            
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            banner.load(request)
        }
        return banner
    }
    
    func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
 
    func updateUIView(_ uiView: BannerView, context: Context) {
    }
}

/// View to display banner ads
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct AdBannerCard: View {
    @Environment(\.adBannerSize) private var adBannerSize
    
    @State private var viewSize: CGSize = .zero
    
    public init() {}
    
    public var body: some View {
        Group {
            AdBannerCardInternal(adBannerSize: adBannerSize ?? .smart(width: viewSize.width))
                .frame(maxHeight: adBannerSize?.size.size.height ?? .infinity)
        }
        .overlay(
            GeometryReader { geometry in
                Color.clear
                    .onChange(of: geometry.size, initial: true) {
                        viewSize = geometry.size
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
//        .environment(\.adBannerSize, adBannerSize == nil ? AdBannerSize(width: viewSize.width) : adBannerSize)
    }
}

typealias AdBanner = AdBannerCard
#endif
