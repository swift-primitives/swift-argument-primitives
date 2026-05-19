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
    /// A boolean flag declaration.
    ///
    /// Declared in a `Command.Schema<Root>` to bind a `--name` (present)
    /// or absent argv element to a `Bool` field on `Root`. Mirrors
    /// swift-argument-parser's `@Flag` property wrapper but as a value
    /// type owned by an explicit schema-as-data declaration.
    ///
    /// ## Arity
    ///
    /// A flag's default arity is `.atMost(1)` — present once or absent.
    /// `.count` arity supports `-vvv` style multi-occurrence counts; in
    /// that mode the bound field type is `Int`, not `Bool`. The schema
    /// layer reconciles type and arity at L3.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Argument.Flag(
    ///     name: .long(try .init("verbose")),
    ///     visibility: .visible,
    ///     help: .init(abstract: "Print verbose output.")
    /// )
    /// ```
    public struct Flag: Sendable, Hashable, Equatable {
        /// The flag's name (short, long, or both).
        public let name: Argument.Name
        /// How the flag is counted. `.atMost(1)` is the default; `.count`
        /// supports `-vvv` style multi-occurrence.
        public let arity: Argument.Arity
        /// Whether this flag appears in help text.
        public let visibility: Argument.Visibility
        /// Documentation for this flag.
        public let help: Argument.Help

        /// Creates a flag declaration.
        ///
        /// - Parameters:
        ///   - name: The flag's name forms.
        ///   - arity: How the flag is counted. Defaults to `.atMost(1)`.
        ///   - visibility: Whether this argument appears in help text. Defaults to `.visible`.
        ///   - help: Documentation. Defaults to empty.
        @inlinable
        public init(
            name: Argument.Name,
            arity: Argument.Arity = .atMost(1),
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init()
        ) {
            self.name = name
            self.arity = arity
            self.visibility = visibility
            self.help = help
        }
    }
}
