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

extension Argument.Name {
    /// A multi-character long option name (e.g., `"verbose"` in `--verbose`).
    ///
    /// Per GNU long-options convention (§4.8), long option names match the
    /// pattern `[a-zA-Z][a-zA-Z0-9-]*` — start with a letter, followed
    /// by letters, digits, or hyphens. This type carries the validated
    /// string; invalid strings trip `Argument.Name.Long.Error` at
    /// construction.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// let name = try Argument.Name.Long("verbose")      // OK
    /// let dashed = try Argument.Name.Long("dry-run")    // OK
    /// let bad = try Argument.Name.Long("9lives")        // throws .doesNotStartWithLetter
    /// let empty = try Argument.Name.Long("")            // throws .empty
    /// ```
    public struct Long: Sendable, Hashable, Equatable {
        /// The validated string.
        public let string: String

        /// Direct construction from an already-validated string.
        ///
        /// The leading underscore + `_unchecked` label signals "bypass
        /// validation; caller asserts the string matches `[a-zA-Z][a-zA-Z0-9-]*`."
        @inlinable
        public init(_unchecked string: String) {
            self.string = string
        }
    }
}

// MARK: - Validated initializer

extension Argument.Name.Long {
    /// Creates a long option name, validating against the GNU long-option
    /// pattern `[a-zA-Z][a-zA-Z0-9-]*`.
    ///
    /// - Parameter string: The candidate long-option string.
    /// - Throws: `Argument.Name.Long.Error` if the string is empty, does
    ///   not start with an ASCII letter, or contains characters outside
    ///   `[a-zA-Z0-9-]`.
    @inlinable
    public init(_ string: String) throws(Argument.Name.Long.Error) {
        guard let first = string.first else {
            throw .empty
        }
        guard first.isASCII, first.isLetter else {
            throw .doesNotStartWithLetter(found: first)
        }
        for character in string.dropFirst() {
            guard character.isASCII else {
                throw .invalidCharacter(found: character)
            }
            guard character.isLetter || character.isNumber || character == "-" else {
                throw .invalidCharacter(found: character)
            }
        }
        self.string = string
    }
}

// MARK: - Literal-name factory

extension Argument.Name.Long {
    /// Constructs a long option name from a known-good literal, trapping
    /// with a descriptive message on validation failure.
    ///
    /// This is the production-site companion to the throwing
    /// ``init(_:)`` — schema authors declaring option names from string
    /// literals at the call site can write:
    ///
    /// ```swift
    /// Command.Option(\.count, name: .long(.literal("count")))
    /// ```
    ///
    /// without scattering `try` across declarative schema bodies. Validation
    /// failure traps with `preconditionFailure` because supplying an
    /// invalid literal is a programmer error, not a runtime concern — the
    /// caller has assured the string is well-formed by writing it as a
    /// `StaticString` at the call site.
    ///
    /// For dynamic runtime-string construction (e.g., names read from a
    /// configuration file), use the throwing ``init(_:)`` instead.
    ///
    /// - Parameter name: A static string matching `[a-zA-Z][a-zA-Z0-9-]*`.
    /// - Returns: The validated long option name.
    @inlinable
    public static func literal(_ name: StaticString) -> Argument.Name.Long {
        let string = "\(name)"
        do {
            return try Argument.Name.Long(string)
        } catch {
            preconditionFailure(
                "Argument.Name.Long.literal: '\(string)' is not a valid GNU long option name (\(error))"
            )
        }
    }
}
