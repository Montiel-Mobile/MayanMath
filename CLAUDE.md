# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

`MayanMath.framework` — an iOS framework providing Mayan base-20 numeral arithmetic and glyph rendering. Bundle id `com.montielmobile.MayanMath`, iOS 13.2 deployment target, Swift 5.0, universal.

This repo is standalone but is normally consumed as a **git submodule** of the Mayan Math app (`MayanCalc`), which references `MayanMath.xcodeproj` as a sub-project and embeds the built framework. Changes here must be committed on this repo's branch first; the consuming repo then bumps its submodule pointer in a separate commit.

Branches: `development` is the working branch, `master` the release branch. Releases are tagged `vN.N` (currently `v1.8`); the version is also written by hand into the class doc comment in `MayanMath.swift`. `README.md` is the public API reference and is published via GitHub Pages (`docs/_config.yml`).

## Commands

```sh
xcodebuild test -project MayanMath.xcodeproj -scheme MayanMath \
  -destination 'platform=iOS Simulator,name=iPhone 17'

# single test
xcodebuild test -project MayanMath.xcodeproj -scheme MayanMath \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:MayanMathTests/MayanMathTests/testMayanOperations
```

`MayanMath.xcscheme` is shared (checked in) with `MayanMathTests` in its test action, so the suite runs from the CLI and in CI.

## Target membership traps

The test target does **not** use `@testable import MayanMath`. It compiles `MayanMath.swift`, `Int+Mayan.swift`, and `UIImage+Mayan.swift` directly into the test bundle — which is why `MayanMathTests.swift` imports only `XCTest` and can call the internal `MayanMath()` initializer instead of the `shared` singleton.

Two consequences when adding files:

- **A new source file must be added to both the `MayanMath` and `MayanMathTests` targets**, or the tests stop compiling with "cannot find X in scope".
- `Assets.xcassets` is likewise a member of both targets. It has to be: `UIImage.symbol(_:_:_:)` loads via `Bundle(for: MayanMath.self)`, which resolves to the *test* bundle when the sources are compiled into it.

## Architecture

### Digit-array representation

The public surface trades in `[Int]` arrays of base-20 place values (each 0…19), **most significant first** — the last element is the 1's place, second-to-last the 20's, then 400's, 8000's. `Int.digitValues(forBase:)` produces them; the base is parameterised but everything calls it with the default 20.

Negative numbers are represented by making *every element* negative, not by a sign flag. `negate()` multiplies each element by -1, and the consuming code decides sign by summing the array.

### Deferred evaluation

`MayanMath` is an `ObservableObject` whose `@Published` arrays (`leftSideDigitValues`, `rightSideDigitValues`, `resultDigitValues`, `mathOp`, `equalEnabled`) are mutated directly by callers. **Mutation computes nothing.** `deriveResults()` is the single evaluation point: it folds both operand arrays into `leftSide`/`rightSide`, applies `mathOp` if `equalEnabled` is true, and repopulates `resultDigitValues`. Any new public mutator must either call it or document that the caller must.

Errors are signalled in-band rather than thrown. Overflow (guarded at `factor > Int.max / 8000`, i.e. three base-20 orders below `Int.max`) and division by zero both set `resultsInt` to `Int.max`, clear `resultDigitValues`, and make `resultsString` return `"Invalid operation"`. The `NSError` constants exist only to drive that internal `do`/`catch`; they never reach callers.

Division stores an integer quotient in `resultsInt` plus an optional `resultsRem`, which `resultsString` renders as `~[remainder]`.

### Glyph composition

Glyphs are assembled at runtime, never stored as complete images:

1. `Int.mayanSymbols(_:_:)` walks the number in base 20. Each place ≥ 5 splits into a bar component (5/10/15) and a dot component (1–4), yielding one or two `UIImage`s per place; places 0–4 yield one. Zero uses the `zeroDown` shell glyph.
2. `MayanMath.image(mayanTop:mayanBottom:)` draws the dot image above the bar image into one square context sized to the bar's width, with `interpolationQuality = .none` — the art is pixel art and must not be smoothed.
3. The composite is returned as `.upMirrored`. Consumers that stamp a background behind it flip back to `.downMirrored`. Changing one side without the other renders glyphs upside down.

`mayanGlyph(forInt:_:_:)` returns only the *last* place's glyph (a `MayanGlyph` tuple of `(int, glyph)`) and is meant for single 0–19 values; `symbols(forInt:_:_:)` returns the full array for arbitrary integers.

### Asset naming is a string contract

`UIImage.symbol(_:_:_:)` builds the asset name by concatenation: `"\(Symbol)\(SymbolType)\(Red?)"`, then force-unwraps the lookup.

- `Symbol`: `one`…`four`, `five`, `ten`, `fifteen`, `zero`, `zeroDown`
- `SymbolType`: `.flat` → `""`, `.bevel` → `"Bevel"`
- negative → `"Red"` suffix

So every symbol needs all four variants — e.g. `five`, `fiveBevel`, `fiveRed`, `fiveBevelRed`. **A missing combination is a crash, not a fallback.** Adding a `Symbol` case or `SymbolType` means adding the full cross product to `Assets.xcassets` at @2x and @3x.

## Conventions

- Every source file carries the MIT license header block; copy it into new files.
- Public API uses Xcode markup doc comments (`- Parameter`, `- Returns`) — the README is written from them by hand, so update both together.
- The framework is a singleton (`MayanMath.shared`) for app use, but tests instantiate it directly to stay isolated.
