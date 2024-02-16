// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "InterfaceStyleObserver",
    platforms: [
        .macCatalyst(.v17)
    ],
    products: [
        .executable(name: "theme-switcher", targets: ["InterfaceStyleObserver"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "InterfaceStyleObserver",
            dependencies: []),
        .testTarget(
            name: "InterfaceStyleObserverTests",
            dependencies: ["InterfaceStyleObserver"]),
    ]
)
