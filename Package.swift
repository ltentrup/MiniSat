import PackageDescription

let package = Package(
    name: "MiniSat",
    dependencies: [
        .Package(url: "../CMiniSat", majorVersion: 0, minor: 1),
        .Package(url: "../SATSolver", majorVersion: 0, minor: 4)
    ]
)
