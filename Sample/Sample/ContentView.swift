//
//  ContentView.swift
//  Sample
//
//  Created by 茅根啓介 on 2025/02/03.
//

import SwiftUI
import AdMobUI

struct ContentView: View {
    @State private var contentViewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        contentViewModel.isOpeningInterstitialAd.toggle()
                    } label: {
                        Text("Show Interstitial Ad")
                    }
                    
                    GroupBox {
                        Button {
                            contentViewModel.isOpeningRewordedAd.toggle()
                        } label: {
                            Text("Show Reworded Ad")
                        }
                    } label: {
                        LabeledContent("Reworded Count", value: contentViewModel.rewordedCount, format: .number)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding(5)
                    .backgroundStyle(.clear)
                    
                    
                    GroupBox {
                        Button {
                            contentViewModel.isOpeningRewordedInterstitialAd.toggle()
                        } label: {
                            Text("Show Reworded Interstitial Ad")
                        }
                    } label: {
                        LabeledContent("Reworded Interstitial Count", value: contentViewModel.rewordedInterstitialCount, format: .number)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding(5)
                    .backgroundStyle(.clear)

                    Toggle(isOn: $contentViewModel.isDisplayingNativeAd) {
                        Text("Show Native Ad")
                    }
                    
                    Toggle(isOn: $contentViewModel.isDisplayingAdBanner) {
                        Text("Show Ad Banner")
                    }
                } header: {
                    Text("Google Admob")
                }
            }
            .navigationTitle("Sample App")
            .safeAreaInset(edge: .bottom) {
                if contentViewModel.isDisplayingAdBanner {
                    AdBannerCard()
                        .frame(height: 300)
                }
            }
//            .adBanner(isPresented: $contentViewModel.isDisplayingAdBanner)
//            .environment(\.adBannerSize, .custom(width: 320, height: 300))
            .safeAreaInset(edge: .bottom) {
                if contentViewModel.isDisplayingNativeAd {
                    NativeAdCard()
                }
            }
        }
        .interstitialAdSheet(isPresented: $contentViewModel.isOpeningInterstitialAd)
        .rewardedAdSheet(isPresented: $contentViewModel.isOpeningRewordedAd) {
            contentViewModel.rewordedCount += 1
        }
        .rewardedInterstitialAdSheet(isPresented: $contentViewModel.isOpeningRewordedInterstitialAd) {
            contentViewModel.rewordedInterstitialCount += 1
        }
    }
}

#Preview {
    ContentView()
}
