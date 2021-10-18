// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MinterKit",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "MinterTransaction",
            targets: ["MinterTransaction"]),
        .library(
            name: "HDWalletKit",
            targets: ["HDWalletKit"]),
        .library(
            name: "MinterWallet",
            targets: ["MinterWallet"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMajor(from: "1.4.2")),
        .package(url: "https://github.com/Boilertalk/secp256k1.swift.git", .upToNextMajor(from: "0.1.0")),
    ],
    targets: [
        .target(
            name: "MinterTransaction",
            dependencies: ["HDWalletKit"],
            path: "MinterTransaction/Sources",
            linkerSettings: [
                .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
            ]
        ),
        .testTarget(
            name: "MinterTransactionTest",
            dependencies: ["MinterTransaction"],
            path: "MinterTransaction/Tests"
        ),
        .target(
            name: "HDWalletKit",
            dependencies: ["CryptoSwift", "secp256k1"],
            path: "HDWalletKit/Sources",
            linkerSettings: [
                .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
            ]
        ),
        .testTarget(
            name: "HDWalletKitTest",
            dependencies: ["HDWalletKit"],
            path: "HDWalletKit/Tests"
        ),
        .target(
            name: "MinterWallet",
            dependencies: ["MinterTransaction", "HDWalletKit"],
            path: "MinterWallet/Sources",
            linkerSettings: [
                .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
            ]
        ),
        .testTarget(
            name: "MinterWalletTest",
            dependencies: ["MinterWallet", "MinterTransaction"],
            path: "MinterWallet/Tests"
        ),
    ]
)
