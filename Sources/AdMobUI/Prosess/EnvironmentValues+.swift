//
//  EnvironmentValues+.swift
//  AdvertisementsUI
//
//  Created by 茅根啓介 on 2025/02/21.
//

import SwiftUI

#if os(iOS)
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension EnvironmentValues {
    @Entry public var adBannerSize: AdBannerSize?
}
#endif
