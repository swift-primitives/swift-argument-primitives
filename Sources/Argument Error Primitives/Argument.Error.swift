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

public import Argument_Primitive
public import Argument_Position_Primitives
public import Diagnostic_Primitives

extension Argument {
    /// Errors produced by argv parsing and schema validation.
    ///
    /// `Argument.Error` is the top-level typed-throws domain for argument
    /// parsing failures. Each case carries the `Argument.Position` where
    /// the failure was detected and a `Diagnostic.Severity` so callers
    /// can promote / demote individual cases per their tolerance for
    /// user-input mistakes.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// throw Argument.Error.unknownOption(name: "--unkown",
    ///                                     position: .init(argvIndex: 1, byteOffset: 0))
    /// ```
    public enum Error: Swift.Error, Sendable, Hashable, Equatable {
        /// An option name was provided that no schema declared.
        case unknownOption(name: String, position: Argument.Position)
        /// An option requires a value but the next argv element was missing or option-shaped.
        case missingValue(name: String, position: Argument.Position)
        /// An option's value did not parse to the expected type.
        case invalidValue(name: String, value: String, position: Argument.Position)
        /// A required positional argument was not provided.
        case missingPositional(name: String, position: Argument.Position)
        /// More positional arguments were supplied than the schema declared.
        case unexpectedPositional(value: String, position: Argument.Position)
        /// A subcommand was required but not provided.
        case missingSubcommand(position: Argument.Position)
        /// A subcommand was provided that no schema declared.
        case unknownSubcommand(name: String, position: Argument.Position)
        /// Cross-field validation rejected an otherwise-parseable argv.
        case validationFailed(reason: String, position: Argument.Position)
    }
}

// MARK: - Accessors

extension Argument.Error {
    /// The argv position the failure is anchored to.
    @inlinable
    public var position: Argument.Position {
        switch self {
        case let .unknownOption(_, position),
             let .missingValue(_, position),
             let .invalidValue(_, _, position),
             let .missingPositional(_, position),
             let .unexpectedPositional(_, position),
             let .missingSubcommand(position),
             let .unknownSubcommand(_, position),
             let .validationFailed(_, position):
            return position
        }
    }

    /// The diagnostic severity to render this error at by default.
    ///
    /// L3 packages MAY override per-case to demote (e.g., a typo to a
    /// remark) but the default is `.error` for every case — argv
    /// parsing failures block command execution.
    @inlinable
    public var severity: Diagnostic.Severity {
        .error
    }
}
