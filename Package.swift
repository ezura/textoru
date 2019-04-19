// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "textoru",
    products: [
        .executable(name: "textoru", targets: ["textoru"])
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "2.2.1"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", .branch("master")),
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "textoru",
            dependencies:  [
                "Files",
                "ShellOut",
                "SwiftSyntax",
            ]),
        .testTarget(
            name: "textoruTests",
            dependencies: ["textoru"]),
    ]
)
