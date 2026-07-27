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
            url: "https://github.com/INFOCITY/richflyer-sdk-swift/releases/download/3.7.8/RichFlyer.xcframework.zip",
            checksum: "e9e330b9c39091e3cf59a4fd34379cc23781b5ba1f78f701eea9829683ba6010"
        )
    ]
)
