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
    /// A subcommand declaration with a parsed value type `S`.
    ///
    /// Subcommands branch the parse tree: at the schema's subcommand
    /// position, one of the declared subcommand names is selected and
    /// the matching subcommand's schema is dispatched to. Mirrors
    /// swift-argument-parser's `CommandConfiguration.subcommands` but
    /// as a value type owned by an explicit schema-as-data declaration.
    /// Per §2.3 of the design, subcommand dispatch semantically maps to
    /// `Parser.OneOf` over a sum type.
    ///
    /// ## Type parameter
    ///
    /// `S` is the type of the subcommand's parsed result. L3 typically
    /// makes `S` a sum-type enum where each case carries the parsed
    /// subcommand value.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Argument.Subcommand<MyCommand.Subcommand>(
    ///     name: "push",
    ///     aliases: ["p"],
    ///     visibility: .visible,
    ///     help: .init(abstract: "Push to the remote.")
    /// )
    /// ```
    public struct Subcommand<S: Sendable>: Sendable {
        /// The subcommand name (e.g., `"push"`).
        public let name: String
        /// Alternative names the subcommand also responds to (e.g., `["p"]`).
        public let aliases: [String]
        /// Whether this subcommand appears in help text.
        public let visibility: Argument.Visibility
        /// Documentation for this subcommand.
        public let help: Argument.Help

        /// Creates a subcommand declaration.
        ///
        /// - Parameters:
        ///   - name: The primary subcommand name.
        ///   - aliases: Alternative names this subcommand also responds to. Defaults to `[]`.
        ///   - visibility: Whether this subcommand appears in help text. Defaults to `.visible`.
        ///   - help: Documentation. Defaults to empty.
        @inlinable
        public init(
            name: String,
            aliases: [String] = [],
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init()
        ) {
            self.name = name
            self.aliases = aliases
            self.visibility = visibility
            self.help = help
        }
    }
}
