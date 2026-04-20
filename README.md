# MilestoneKit

A SwiftUI library for version-keyed onboarding and "what's new" screens on Apple platforms. First-run onboarding and upgrade walkthroughs are the same UX pattern triggered at different points in the app lifecycle, so MilestoneKit treats them as one primitive.

## Lineage

MilestoneKit is a Swift 6 / SwiftUI rewrite of [SvenTiigi/WhatsNewKit](https://github.com/SvenTiigi/WhatsNewKit) by Sven Tiigi. The original MIT license is preserved in [`LICENSE`](./LICENSE). The public API is **not** compatible with WhatsNewKit v2.x; this is a full rewrite rather than a point release.

## Status

Pre-v1. Under active rewrite. Not ready for production use.

## Platforms

- macOS 15+
- iOS 18+
- visionOS 2+

Liquid Glass (OS 26) paths are `@available(* 26, *)`-gated with material fallbacks on earlier OSes.

## License

MIT. See [`LICENSE`](./LICENSE).
