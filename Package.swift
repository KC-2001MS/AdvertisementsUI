// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdvertisementsUI",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AdMobAdsUI",
            targets: ["AdMobAdsUI"]
        ),
        .library(
            name: "AppLovinAdsUI",
            targets: ["AppLovinAdsUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", from: "11.13.0"),
        .package(url: "https://github.com/AppLovin/AppLovin-MAX-Swift-Package.git", from: "13.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AdMobAdsUI",
            dependencies: [
                .product(
                    name: "GoogleMobileAds",
                    package: "swift-package-manager-google-mobile-ads"
                )
            ]
        ),
        .target(
            name: "AppLovinAdsUI",
            dependencies: [
                .product(
                    name: "AppLovinSDK",
                    package: "AppLovin-MAX-Swift-Package"
                )
            ]
        ),
        .testTarget(
            name: "AdUITests",
            dependencies: [
                "AdMobAdsUI",
                "AppLovinAdsUI"
            ]
        ),
    ]
)
