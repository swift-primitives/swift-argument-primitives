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

extension Argument.Token {
    /// The semantic kind of an argv-derived token after L2 tokenization
    /// has classified each argv element.
    ///
    /// Kinds correspond to the post-tokenization view of a single argv
    /// element. The L2 tokenizer (POSIX 12.2, GNU long-options) emits a
    /// stream of `Argument.Token` values whose `kind` reflects the
    /// classification:
    ///
    /// - `.long("foo")` — a `--foo`-shaped element (the leading `--` is
    ///   already stripped; the payload is the name only).
    /// - `.shortCluster("xyz")` — a `-xyz`-shaped element (the leading
    ///   `-` is already stripped; the payload may be a cluster of short
    ///   options per POSIX G5).
    /// - `.value("v")` — a value bound to a preceding option (e.g., the
    ///   `v` in `--foo v` or in `--foo=v` after the `=`-split).
    /// - `.separator` — the `=` in `--foo=v` form (rarely surfaced; the
    ///   tokenizer typically splits and emits `.long("foo")` + `.value("v")`
    ///   directly).
    /// - `.positional("path")` — a non-option-shaped argv element
    ///   intended as a positional argument.
    /// - `.endOfOptions` — the `--` separator that terminates option
    ///   parsing. Subsequent argv elements are all positional regardless
    ///   of leading dashes.
    public enum Kind: Sendable, Hashable, Equatable {
        /// A long-option name (e.g., `--verbose` → `.long("verbose")`).
        case long(String)
        /// A short-option cluster (e.g., `-xvf` → `.shortCluster("xvf")`).
        case shortCluster(String)
        /// A value bound to a preceding option.
        case value(String)
        /// The `=` separator inside `--foo=v`.
        case separator
        /// A positional (non-option) argument.
        case positional(String)
        /// The `--` end-of-options separator.
        case endOfOptions
    }
}
