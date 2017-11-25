// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftyJIRA",
    products: [
        .library(name: "SwiftyJIRA", targets: ["SwiftyJIRA"])
    ],
    dependencies: [
        .package(url: "https://github.com/JrGoodle/Alamofire.git", .branch("linux"))
    ],
    targets: [
        .target(name: "SwiftyJIRA", dependencies: ["Alamofire"], path: "Sources"),
        .testTarget(name: "SwiftyJIRATests", dependencies: ["SwiftyJIRA"])
    ]
)

