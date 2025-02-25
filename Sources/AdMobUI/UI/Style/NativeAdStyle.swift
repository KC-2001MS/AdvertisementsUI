//
//  NativeAdStyle.swift
//  AdUI
//
//  Created by 茅根啓介 on 2025/02/06.
//
#if canImport(GoogleMobileAds)
import SwiftUI
@preconcurrency import GoogleMobileAds

@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public protocol NativeAdStyle {
    typealias Configuration = NativeAdStyleConfiguration

    associatedtype Body: View
    
    func makeBody(configuration: Configuration) -> Body
}

@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct NativeAdStyleConfiguration {
    let nativeAd: NativeAd?
}

@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NativeAdStyle where Self == DefaultNativeAdStyle {
    /// The default article style, based on the article’s context.
    public static var automatic: DefaultNativeAdStyle {
        get {
            DefaultNativeAdStyle()
        }
    }
}

@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NativeAdStyle where Self == CompactNativeAdStyle {
    /// The default article style, based on the article’s context.
    public static var compact: CompactNativeAdStyle {
        get {
            CompactNativeAdStyle()
        }
    }
}

@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct DefaultNativeAdStyle: NativeAdStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                if let image = configuration.nativeAd?.icon?.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    if let headline = configuration.nativeAd?.headline {
                        Text(headline)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(2)
                    }
                    
                    HStack {
                        if let starRating = configuration.nativeAd?.starRating {
                            Label {
                                Text("\(starRating)")
                                    .font(.caption)
                                    .bold()
                            } icon: {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                            .font(.subheadline)
                            
                            if configuration.nativeAd?.price != nil {
                                Divider()
                            }
                        }
                        
                        if let price = configuration.nativeAd?.price {
                            Text(price)
                                .font(.caption)
                                .bold()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            
            if let body = configuration.nativeAd?.body {
                Text(body)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            
            Group {
                if let callToAction = configuration.nativeAd?.callToAction {
                    Button {
                        
                    } label: {
                        Text(callToAction)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(height: 50)
            
            if let advertiser = configuration.nativeAd?.advertiser {
                Text(advertiser)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .safeAreaInset(edge: .top) {
            if let imageData = configuration.nativeAd?.images?.map({ $0.image }) {
                ScrollView(.horizontal) {
                    ForEach(imageData, id: \.self) { data in
                        Image(uiImage: data ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 500)
                            .containerRelativeFrame(.horizontal)
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .frame(maxWidth: .infinity)
            }
        }
        .overlay {
            if configuration.nativeAd == nil {
                ProgressView()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
            }
        }
    }
}

@available(iOS, introduced: 17.0, message: "It is currently incomplete and not recommended for use.")
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct CompactNativeAdStyle: NativeAdStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                if let image = configuration.nativeAd?.icon?.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    if let headline = configuration.nativeAd?.headline {
                        Text(headline)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(2)
                    }
                    
                    HStack {
                        if let starRating = configuration.nativeAd?.starRating {
                            Label {
                                Text("\(starRating)")
                                    .font(.caption)
                                    .bold()
                            } icon: {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                            .font(.subheadline)
                        }
                        
                        Divider()
                        
                        if let price = configuration.nativeAd?.price {
                            Text(price)
                                .font(.caption)
                                .bold()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            
            if let body = configuration.nativeAd?.body {
                Text(body)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            
            Group {
                if let callToAction = configuration.nativeAd?.callToAction {
                    Button {
                        
                    } label: {
                        Text(callToAction)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(height: 50)
            
            if let advertiser = configuration.nativeAd?.advertiser {
                Text(advertiser)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .overlay {
            if configuration.nativeAd == nil {
                ProgressView()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
            }
        }
    }
}
#endif
