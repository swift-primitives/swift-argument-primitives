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
        case let .short(value): return value
        case .long: return nil
        case let .both(short, _): return short
        }
    }

    /// The long form, if present.
    @inlinable
    public var long: Argument.Name.Long? {
        switch self {
        case .short: return nil
        case let .long(value): return value
        case let .both(_, long): return long
        }
    }
}

// MARK: - Literal-name factories

extension Argument.Name {
    /// Constructs a `.long(_)` name from a known-good literal, trapping
    /// on validation failure.
    ///
    /// Production-site companion enabling declarative schema bodies free
    /// of `try` for literal option-name construction:
    ///
    /// ```swift
    /// Command.Option(\.count, name: .longLiteral("count"))
    /// ```
    ///
    /// Equivalent to `.long(.literal(name))` — the convenience factory
    /// hoists the dotted form to top-level on `Argument.Name`.
    ///
    /// For dynamic runtime-string construction, use
    /// ``Argument/Name/Long/init(_:)`` directly.
    ///
    /// - Parameter name: A static string matching `[a-zA-Z][a-zA-Z0-9-]*`.
    /// - Returns: A `.long(_)` name carrying the validated long form.
    @inlinable
    public static func longLiteral(_ name: StaticString) -> Argument.Name {
        .long(.literal(name))
    }

    /// Constructs a `.short(_)` name from a known-good literal character,
    /// trapping on validation failure.
    ///
    /// Production-site companion enabling declarative schema bodies free
    /// of `try` for literal option-name construction:
    ///
    /// ```swift
    /// Command.Flag(\.verbose, name: .shortLiteral("v"))
    /// ```
    ///
    /// Equivalent to `.short(.literal(name))` — the convenience factory
    /// hoists the dotted form to top-level on `Argument.Name`.
    ///
    /// - Parameter name: A single ASCII alphanumeric character literal.
    /// - Returns: A `.short(_)` name carrying the validated short form.
    @inlinable
    public static func shortLiteral(_ name: Character) -> Argument.Name {
        .short(.literal(name))
    }

    /// Constructs a `.both(short:long:)` name from known-good literals,
    /// trapping on validation failure.
    ///
    /// Production-site companion enabling declarative schema bodies free
    /// of `try` when binding both a short and long form:
    ///
    /// ```swift
    /// Command.Flag(\.verbose, name: .bothLiteral(short: "v", long: "verbose"))
    /// ```
    ///
    /// - Parameters:
    ///   - short: A single ASCII alphanumeric character literal.
    ///   - long: A static string matching `[a-zA-Z][a-zA-Z0-9-]*`.
    /// - Returns: A `.both(short:long:)` name carrying both validated forms.
    @inlinable
    public static func bothLiteral(
        short: Character,
        long: StaticString
    ) -> Argument.Name {
        .both(short: .literal(short), long: .literal(long))
    }
}
