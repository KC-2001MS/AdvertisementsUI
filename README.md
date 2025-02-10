# AdvertisementsUI

Framework for displaying ads using SwiftUI

## Description

With this library, you can display ads with simple SwiftUI code.
It will support AppLovin as well as Admob.

## Requirement

The following environment is required to use this library.  

<p align="center">
    <img src="https://img.shields.io/badge/iOS-17.0+-green.svg" />
    <img src="https://img.shields.io/badge/iPadOS-17.0+-brightgreen.svg" />
    <img src="https://img.shields.io/badge/Swift-6.0-DE5D43.svg" />
    <a href="https://twitter.com/IroIro1234work">
        <img src="https://img.shields.io/badge/Contact-@IroIro1234work-lightgrey.svg?style=flat" alt="Twitter: @IroIro1234work" />
    </a>
</p>

## Demo
Basically, the following methods are used to display the information.
### 1. Preparation
``` swift
import SwiftUI
import AdMobUI

@main
struct SampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .admobContainer()
    }
}
```
### 2. Display
#### Banner
``` swift
import SwiftUI
import AdMobUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            AdBanner()
        }
    }
}
```
#### Native
``` swift
import SwiftUI
import AdMobUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NativeAdCard()
                } header: {
                    Text("Google Admob")
                }
            }
            .navigationTitle("Ads Sample")
        }
    }
}
```
#### Interstitial
``` swift
import SwiftUI
import AdMobUI

struct ContentView: View {
    @State private var isOpeningInterstitialAd = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        isOpeningInterstitialAd.toggle()
                    } label: {
                        Text("Show Interstitial Ad")
                    }
                } header: {
                    Text("Google Admob")
                }
            }
            .navigationTitle("Ads Sample")
        }
        .interstitialAdSheet(isPresented: $isOpeningInterstitialAd)
    }
}
```
#### Reworded
``` swift
import SwiftUI
import AdMobUI

struct ContentView: View {
    @State private var isOpeningRewordedAd = false
    
    @State private var rewordedCount = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
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
                } header: {
                    Text("Google Admob")
                }
            }
            .navigationTitle("Ads Sample")
        }
        .rewardedAdSheet(isPresented: $isOpeningRewordedAd) {
            rewordedCount += 1
        }
    }
}
```
#### Reworded Interstitial
``` swift
import SwiftUI
import AdMobUI

struct ContentView: View {
    @State private var isOpeningRewordedInterstitialAd = false
    
    @State private var rewordedInterstitialCount = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
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
                } header: {
                    Text("Google Admob")
                }
            }
            .navigationTitle("Ads Sample")
            
            
            AdBanner()
                .padding(0)
        }
        .rewardedInterstitialAdSheet(isPresented: $isOpeningRewordedInterstitialAd) {
            rewordedInterstitialCount += 1
        }
    }
}
```

To verify the operation of this library, I created a sample application in the library. Please refer to it.

## Usage
It will be described in detail at a later date.

## Swift-DocC

Swift-DocC is currently being implemented.

[Documentation](https://kc-2001ms.github.io/AdvertisementsUI/documentation/admobui/)

## Install

AdvertisementsUI comes with two different frameworks.
Each framework has a different configuration method.

### AdMobUI
1. [Adding package dependencies to your app](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app)
2. Add the following to info.plist
```plist
    <key>NSUserTrackingUsageDescription</key>
    <string>{some reason}</string>
    <key>SKAdNetworkItems</key>
    <array>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>cstr6suwn9.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>4fzdc2evr5.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>2fnua5tdw4.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>ydx93a7ass.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>p78axxw29g.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>v72qych5uu.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>ludvb6z3bs.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>cp8zw746q7.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3sh42y64q3.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>c6k4g5qg8m.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>s39g8k73mm.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3qy4746246.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>hs6bdukanm.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>mlmmfzh3r3.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>v4nxqhlyqp.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>wzmmz9fp6w.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>su67r6k2v3.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>yclnxrl5pm.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>7ug5zh24hu.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>gta9lk7p23.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>vutu7akeur.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>y5ghdn5j9k.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>v9wttpbfk9.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>n38lu8286q.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>47vhws6wlr.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>kbd757ywx3.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>9t245vhmpl.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>a2p9lx4jpn.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>22mmun2rn5.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>4468km3ulz.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>2u9pt9hc89.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>8s468mfl3y.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>ppxm28t8ap.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>uw77j35x4d.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>pwa73g5rt2.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>578prtvx9j.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>4dzt52r2t5.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>tl55sbb4fm.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>e5fvkxwrpn.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>8c4e2ghe7u.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3rd42ekr43.skadnetwork</string>
        </dict>
        <dict>
            <key>SKAdNetworkIdentifier</key>
            <string>3qcr597p9d.skadnetwork</string>
        </dict>
    </array>
    <key>GADIsAdManagerApp</key>
    <true/>
```
3. Add the following to info.plist
The values of the keys in the AdUnitIDs dictionary are the following keys if not specified in the Swift code.
If specified, custom keys can be used.

```plist
    <key>GADApplicationIdentifier</key>
    <string>{some identifier}</string>
    <key>AdUnitIDs</key>
    <dict>
        <key>Banner</key>
        <string>{some identifier}</string>
        <key>Interstitial</key>
        <string>{some identifier}</string>
        <key>Native</key>
        <string>{some identifier}</string>
        <key>Rewarded</key>
        <string>{some identifier}</string>
        <key>RewardedInterstitial</key>
        <string>{some identifier}</string>
    </dict>
```
4. Add code
See demo for details

<!--### AppLovinUI-->
<!---->
<!--It will be described in detail at a later date.-->

## Contribution
See [CONTRIBUTING.md](https://github.com/KC-2001MS/AdvertisementsUI/blob/main/CONTRIBUTING.md) if you want to make a contribution.

## Licence
[AdvertisementsUI](https://github.com/KC-2001MS/AdvertisementsUI/blob/main/LICENSE)

## Dependencies
This project depends on the following Apache-2.0 licensed libraries:

- **GogleMobileAds** (Version 12.0.0) - [License](LICENSES/GogleMobileAds_LICENSE)
- **GoogleUserMessagingPlatform** (Version 2.7.0) - [License](LICENSES/GoogleUserMessagingPlatform_LICENSE)
- **SwiftDocCPlugin** (Version 1.4.3) - [License](LICENSES/SwiftDocCPlugin_LICENSE)
- **SymbolKit** (Version 1.0.0) - [License](LICENSES/SymbolKit_LICENSE)

## Supporting

If you would like to make a donation to this project, please click here. The money you give will be used to improve my programming skills and maintain the application.   
<a href="https://www.buymeacoffee.com/iroiro" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" >
</a>  
[Pay by PayPal](https://paypal.me/iroiroWork?country.x=JP&locale.x=ja_JP)

## Author

[Keisuke Chinone](https://github.com/KC-2001MS)
