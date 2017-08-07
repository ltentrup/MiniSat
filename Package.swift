import PackageDescription

let package = Package(
    name: "MiniSat",
    targets: [
        Target(name: "MiniSat", dependencies: ["CMiniSat"]),
        Target(name: "CMiniSat", dependencies: ["CppMiniSat"]),
        Target(name: "CppMiniSat"),
    ],
    dependencies: [
        .Package(url: "https://github.com/ltentrup/SATSolver.git", majorVersion: 0, minor: 1)
    ]
)
