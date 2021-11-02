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
        .library(
            name: "MinterGRPC",
            targets: ["MinterGRPC"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMajor(from: "1.4.2")),
        .package(url: "https://github.com/Boilertalk/secp256k1.swift.git", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/grpc/grpc-swift.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-protobuf.git", .upToNextMajor(from: "1.6.0")),
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
            name: "MinterGRPC",
            dependencies: [.product(name: "GRPC", package: "grpc-swift"), "SwiftProtobuf"],
            path: "MinterGRPC/Sources",
            linkerSettings: [
                .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
            ]
        ),
        .testTarget(
            name: "MinterGRPCTest",
            dependencies: ["MinterGRPC", .product(name: "GRPC", package: "grpc-swift"), "SwiftProtobuf"],
            path: "MinterGRPC/Tests"
        ),
        .target(
            name: "MinterWallet",
            dependencies: ["MinterTransaction", "HDWalletKit", "MinterGRPC"],
            path: "MinterWallet/Sources",
            linkerSettings: [
                .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
            ]
        ),
        .testTarget(
            name: "MinterWalletTest",
            dependencies: ["MinterWallet", "MinterTransaction", "MinterGRPC"],
            path: "MinterWallet/Tests"
        ),
    ]
)
