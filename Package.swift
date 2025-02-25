// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdvertisementsUI",
    defaultLocalization: LanguageTag(rawValue: "en"),
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "AdMobUI",
            targets: ["AdMobUI"]
        ),
//        .library(
//            name: "AppLovinUI",
//            targets: ["AppLovinUI"]
//        ),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", from: "12.0.0"),
//        .package(url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git", from: "13.1.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.4.3"),
    ],
    targets: [
        .target(
            name: "AdMobUI",
            dependencies: [
                .product(
                    name: "GoogleMobileAds",
                    package: "swift-package-manager-google-mobile-ads"
                )
            ],
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
//        .target(
//            name: "AppLovinUI",
//            dependencies: [
//                .product(
//                    name: "AppLovinSDK",
//                    package: "AppLovin-MAX-Swift-Package"
//                )
//            ]
//        ),
        .testTarget(
            name: "AdUITests",
            dependencies: [
                "AdMobUI"
//                "AppLovinUI"
            ]
        ),
    ]
)
