// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "XMLMapper",
    platforms: [
        .watchOS(.v2),
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9),
    ],
    products: [
        .library(name: "XMLMapper", targets: ["XMLMapper"]),
    ],
    targets: [
        .target(name: "XMLMapper", path: "./XMLMapper/Classes", exclude: ["Requests"]),
        .testTarget(name: "XMLMapperTests", dependencies: ["XMLMapper"], path: "./XMLMapperTests/Tests"),
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
