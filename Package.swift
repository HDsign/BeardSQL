import PackageDescription

let package = Package(
    name: "MySQL",
    dependencies: [
        .Package(url: "https://github.com/vapor/mysql.git", majorVersion: 1),
    ]
)
