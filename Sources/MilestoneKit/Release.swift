import Foundation

/// A versioned announcement screen.
///
/// MilestoneKit treats first-run onboarding and upgrade "what's new" screens as
/// the same primitive, keyed by ``Version`` and shown at most once per version
/// via a ``ReleaseStore``. A release targeting ``Version`` ``1.0.0`` is the
/// onboarding screen; a release targeting a later version is the upgrade screen.
public struct Release: Sendable {
    public var version: Version

    public init(version: Version) {
        self.version = version
    }
}

extension Release: Identifiable {
    public var id: Version { version }
}
