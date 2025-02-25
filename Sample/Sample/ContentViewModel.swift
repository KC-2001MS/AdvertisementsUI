//
//  ContentViewModel.swift
//  Sample
//
//  Created by 茅根啓介 on 2025/02/21.
//

import Observation

@Observable
final class ContentViewModel {
    var isOpeningInterstitialAd = false
    
    var isOpeningRewordedAd = false
    
    var isOpeningRewordedInterstitialAd = false
    
    var rewordedCount = 0
    
    var rewordedInterstitialCount = 0
    
    var isDisplayingAdBanner = true
}
