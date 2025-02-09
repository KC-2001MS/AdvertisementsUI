//
//  ContentView.swift
//  Sample
//
//  Created by 茅根啓介 on 2025/02/03.
//

import SwiftUI
import AdMobUI

struct ContentView: View {
    @State private var isOpeningInterstitialAd = false
    
    @State private var isOpeningRewordedAd = false
    
    @State private var isOpeningRewordedInterstitialAd = false
    
    @State private var rewordedCount = 0
    
    @State private var rewordedInterstitialCount = 0
    
    @State private var nativeAdViewModel = NativeAdManager()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        isOpeningInterstitialAd.toggle()
                    } label: {
                        Text("Show Interstitial Ad")
                    }
                    
                    GroupBox {
                        Button {
                            isOpeningRewordedAd.toggle()
                        } label: {
                            Text("Show Reworded Ad")
                        }
                    } label: {
                        LabeledContent("Reworded Count", value: rewordedCount, format: .number)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding(5)
                    .backgroundStyle(.clear)
                    
                    
                    GroupBox {
                        Button {
                            isOpeningRewordedInterstitialAd.toggle()
                        } label: {
                            Text("Show Reworded Interstitial Ad")
                        }
                    } label: {
                        LabeledContent("Reworded Interstitial Count", value: rewordedInterstitialCount, format: .number)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding(5)
                    .backgroundStyle(.clear)
                    
                    if let nativeAd = nativeAdViewModel.nativeAd {
                        NativeAdCard(nativeAd: nativeAd)
                    }
                } header: {
                    Text("Google Admob")
                }
            }
            .navigationTitle("Ads Sample")
            
            
            AdBanner()
                .padding(0)
        }
        .interstitialAdSheet(isPresented: $isOpeningInterstitialAd)
        .rewardedAdSheet(isPresented: $isOpeningRewordedAd) {
            rewordedCount += 1
        }
        .rewardedInterstitialAdSheet(isPresented: $isOpeningRewordedInterstitialAd) {
            rewordedInterstitialCount += 1
        }
        .task {
            nativeAdViewModel.loadAd()
        }
    }
}

#Preview {
    ContentView()
}
