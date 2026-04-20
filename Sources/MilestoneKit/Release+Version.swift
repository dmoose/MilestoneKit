public import Foundation

public extension Release {
    /// A semver-style `major.minor.patch` release identifier.
    ///
    /// `Version` is `Comparable` using numeric ordering (not lexical), so `1.10.0`
    /// sorts after `1.2.0`. Literal initialization is supported:
    /// `let v: Release.Version = "1.2.3"`. Components missing from the literal
    /// default to `0`.
    struct Version: Sendable, Hashable {
        public var major: Int
        public var minor: Int
        public var patch: Int

        public init(major: Int, minor: Int, patch: Int) {
            self.major = major
            self.minor = minor
            self.patch = patch
        }
    }
}

extension Release.Version: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.major != rhs.major { return lhs.major < rhs.major }
        if lhs.minor != rhs.minor { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }
}

extension Release.Version: CustomStringConvertible {
    public var description: String {
        "\(major).\(minor).\(patch)"
    }
}

extension Release.Version: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let parts = value.split(separator: ".").map { Int($0) ?? 0 }
        self.major = parts.indices.contains(0) ? parts[0] : 0
        self.minor = parts.indices.contains(1) ? parts[1] : 0
        self.patch = parts.indices.contains(2) ? parts[2] : 0
    }
}

public extension Release.Version {
    /// Reads `CFBundleShortVersionString` from the given bundle and parses it as
    /// a `Version`. Components missing or unparsable fall back to `0`.
    static func current(in bundle: Bundle = .main) -> Release.Version {
        let short = bundle.infoDictionary?["CFBundleShortVersionString"] as? String
        return .init(stringLiteral: short ?? "")
    }

    /// The `major.minor.0` floor of this version — used by the presentation
    /// resolver to fall back to the nearest declared release when no exact
    /// match exists for a patch-level build.
    var minorFloor: Release.Version {
        .init(major: major, minor: minor, patch: 0)
    }
}
