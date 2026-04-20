import Foundation
import Testing
@testable import MilestoneKit

@Suite("Release.Version")
struct VersionTests {
    @Test
    func stringLiteralParsesSemver() {
        let v: Release.Version = "1.2.3"
        #expect(v.major == 1)
        #expect(v.minor == 2)
        #expect(v.patch == 3)
    }

    @Test
    func partialStringLiteralDefaultsMissingComponentsToZero() {
        let a: Release.Version = "2"
        #expect(a == Release.Version(major: 2, minor: 0, patch: 0))
        let b: Release.Version = "2.5"
        #expect(b == Release.Version(major: 2, minor: 5, patch: 0))
    }

    @Test
    func emptyStringParsesAsZeroTriple() {
        let v: Release.Version = ""
        #expect(v == Release.Version(major: 0, minor: 0, patch: 0))
    }

    @Test
    func descriptionIsDottedTriple() {
        #expect(Release.Version(major: 1, minor: 2, patch: 3).description == "1.2.3")
        #expect(Release.Version(major: 0, minor: 0, patch: 0).description == "0.0.0")
    }

    @Test("Comparison is numeric, not lexical")
    func comparisonIsNumeric() {
        let lower: Release.Version = "1.2.0"
        let higher: Release.Version = "1.10.0"
        // Lexical compare would sort "1.10.0" < "1.2.0" — ours must not.
        #expect(lower < higher)
        #expect(higher > lower)
    }

    @Test
    func comparisonOrdersAcrossAllComponents() {
        #expect(Release.Version("0.9.9") < Release.Version("1.0.0"))
        #expect(Release.Version("1.0.9") < Release.Version("1.1.0"))
        #expect(Release.Version("1.0.0") == Release.Version("1.0.0"))
    }

    @Test
    func minorFloorZerosPatchComponent() {
        let v: Release.Version = "3.4.7"
        #expect(v.minorFloor == Release.Version(major: 3, minor: 4, patch: 0))
    }

    @Test
    func currentFallsBackToZeroWhenBundleLacksShortVersion() {
        // The test bundle has no CFBundleShortVersionString; current() should
        // therefore produce the zero-triple instead of throwing.
        let v = Release.Version.current(in: Bundle(for: ProbeClass.self))
        #expect(v == Release.Version(major: 0, minor: 0, patch: 0))
    }
}

// Anchor so Bundle(for:) resolves to the test bundle.
private final class ProbeClass {}
