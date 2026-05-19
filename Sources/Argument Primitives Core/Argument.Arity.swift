// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-argument-primitives open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-argument-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Argument {
    /// How many values an argument consumes.
    ///
    /// `Arity` carries the expected cardinality of values bound to a
    /// positional, option, or flag. Schemas use this for validation
    /// (insufficient values → error) and for help-text emission (e.g.,
    /// `<value>` vs `<value>...`).
    ///
    /// ## Cases
    ///
    /// - `.exactly(n)` — exactly `n` values (typical for options taking one value).
    /// - `.atMost(n)` — between zero and `n` values inclusive.
    /// - `.atLeast(n)` — `n` or more values (positional rest, varargs).
    /// - `.range(n...m)` — between `n` and `m` values inclusive.
    /// - `.count` — number of occurrences (e.g., `-vvv` → 3, for verbosity).
    public enum Arity: Sendable, Hashable, Equatable {
        /// Exactly `n` values consumed.
        case exactly(Int)
        /// At most `n` values consumed.
        case atMost(Int)
        /// At least `n` values consumed.
        case atLeast(Int)
        /// Between `n` and `m` values, inclusive.
        case range(ClosedRange<Int>)
        /// Number of occurrences counted (e.g., `-vvv`).
        case count
    }
}
