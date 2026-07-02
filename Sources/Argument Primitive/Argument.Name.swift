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
    /// The identifying name(s) of an option or flag.
    ///
    /// An argument may be addressable by a single short form (`-f`), a
    /// single long form (`--foo`), or both. This enum models the three
    /// cases as a sum type.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// // Short only: -v
    /// let v = Argument.Name.short(try .init("v"))
    ///
    /// // Long only: --verbose
    /// let verbose = Argument.Name.long(try .init("verbose"))
    ///
    /// // Both: -v / --verbose
    /// let both = Argument.Name.both(
    ///     short: try .init("v"),
    ///     long: try .init("verbose")
    /// )
    /// ```
    public enum Name: Sendable, Hashable, Equatable {
        /// A short option name only (e.g., `-f`).
        case short(Argument.Name.Short)
        /// A long option name only (e.g., `--foo`).
        case long(Argument.Name.Long)
        /// Both a short and a long form (e.g., `-f` / `--foo`).
        case both(short: Argument.Name.Short, long: Argument.Name.Long)
    }
}

// MARK: - Accessors

extension Argument.Name {
    /// The short form, if present.
    @inlinable
    public var short: Argument.Name.Short? {
        switch self {
        case .short(let value): return value
        case .long: return nil
        case .both(let short, _): return short
        }
    }

    /// The long form, if present.
    @inlinable
    public var long: Argument.Name.Long? {
        switch self {
        case .short: return nil
        case .long(let value): return value
        case .both(_, let long): return long
        }
    }
}

// Literal-name factories deleted: consumers use the canonical dotted form
// `.long(.literal(name))` / `.short(.literal(char))` / `.both(short:long:)`
// directly. The longLiteral/shortLiteral/bothLiteral convenience hoists
// were compound-named (per [API-NAME-002]) and the longer dotted form
// reads cleanly enough that the hoist had no ergonomic payoff.
