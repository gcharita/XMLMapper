// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "XMLMapper",
    products: [
        .library(name: "XMLMapper", targets: ["XMLMapper"]),
    ],
    targets: [
        .target(name: "XMLMapper", path: "./XMLMapper/Classes", exclude: ["Requests"]),
        .testTarget(name: "XMLMapperTests", dependencies: ["XMLMapper"], path: "./XMLMapperTests/Tests"),
    ],
    swiftLanguageVersions: [.v3, .v4, .v4_2]
)
