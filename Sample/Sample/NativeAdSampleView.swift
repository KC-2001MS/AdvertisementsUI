//
//  NativeAdSampleView.swift
//  Sample
//
//  Created by 茅根啓介 on 2025/02/26.
//

import SwiftUI
import AdMobUI

struct NativeAdSampleView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    Text("Default")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        
                    NativeAdCard()
                
                    Text("Compact")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        
                    NativeAdCard()
                        .nativeAdStyle(.compact)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .secondarySystemBackground))
            .listStyle(.inset)
            .navigationTitle("Native Ads")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color.clear,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
