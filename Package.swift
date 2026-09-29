// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SwiftRichFlyer",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "RichFlyer",
            targets: ["RichFlyer"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "RichFlyer",
            url: "https://github.com/INFOCITY/richflyer-sdk-swift/releases/download/3.7.9/RichFlyer.xcframework.zip",
            checksum: "92fb4791debfffb0b4818aa142bb5cea503c5849971cc2a3016988438f021fda"
        )
    ]
)
