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
    /// A single-character short option name (e.g., `'f'` in `-f`).
    ///
    /// Per POSIX 12.2 Guideline 3, option names are single alphanumeric
    /// characters. This type carries the validated character; invalid
    /// characters trip `Argument.Name.Short.Error` at construction.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// let name = try Argument.Name.Short("f")              // OK
    /// let bad = try Argument.Name.Short("ø")               // throws .notASCIIAlphanumeric
    /// ```
    public struct Short: Sendable, Hashable, Equatable {
        /// The validated character.
        public let character: Character

        /// Direct construction from an already-validated character.
        ///
        /// The leading underscore + `_unchecked` label signals "bypass
        /// validation; caller asserts the character is a single ASCII
        /// alphanumeric." Used by the validating initializer after the
        /// check passes; callers who need to skip validation (e.g., test
        /// fixtures known to be valid) may also use this path.
        @inlinable
        public init(_unchecked character: Character) {
            self.character = character
        }
    }
}

// MARK: - Validated initializer

extension Argument.Name.Short {
    /// Creates a short option name, validating the character is a single
    /// ASCII alphanumeric per POSIX 12.2 Guideline 3.
    ///
    /// - Parameter character: A single ASCII alphanumeric character.
    /// - Throws: `Argument.Name.Short.Error.notASCIIAlphanumeric` if the
    ///   character is not a single ASCII alphanumeric.
    @inlinable
    public init(_ character: Character) throws(Argument.Name.Short.Error) {
        guard character.isASCII, character.isLetter || character.isNumber else {
            throw .notASCIIAlphanumeric(found: character)
        }
        self.character = character
    }
}

// MARK: - Literal-name factory

extension Argument.Name.Short {
    /// Constructs a short option name from a known-good literal character,
    /// trapping with a descriptive message on validation failure.
    ///
    /// This is the production-site companion to the throwing
    /// ``init(_:)`` — schema authors declaring option names from
    /// character literals at the call site can write:
    ///
    /// ```swift
    /// Command.Flag(\.verbose, name: .short(.literal("v")))
    /// ```
    ///
    /// without scattering `try` across declarative schema bodies. Validation
    /// failure traps with `preconditionFailure` because supplying an
    /// invalid literal is a programmer error, not a runtime concern.
    ///
    /// For dynamic runtime-character construction, use the throwing
    /// ``init(_:)`` instead.
    ///
    /// - Parameter name: A single ASCII alphanumeric character literal.
    /// - Returns: The validated short option name.
    @inlinable
    public static func literal(_ name: Character) -> Argument.Name.Short {
        do throws(Argument.Name.Short.Error) {
            return try Argument.Name.Short(name)
        } catch {
            preconditionFailure(
                "Argument.Name.Short.literal: '\(name)' is not a single ASCII alphanumeric (\(error))"
            )
        }
    }
}
