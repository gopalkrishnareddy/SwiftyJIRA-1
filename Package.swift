// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftyJIRA",
    products: [
        .library(name: "SwiftyJIRA", targets: ["SwiftyJIRA"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .target(name: "SwiftyJIRA", dependencies: ["Alamofire"], path: "Sources")
    ]
)

