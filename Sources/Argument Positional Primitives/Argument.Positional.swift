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
    /// A positional argument declaration with a parsed value type `V`.
    ///
    /// Declared in a `Command.Schema<Root>` to bind one argv element to
    /// a field on `Root`. Mirrors swift-argument-parser's `@Argument`
    /// property wrapper but as a value type owned by an explicit
    /// schema-as-data declaration, per §2.2 of the design.
    ///
    /// Generic over `V` so the schema visitor at L3 sees the same
    /// value-typed information the parser sees — there is no second
    /// source of truth between parse logic and help-text emission.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // At L3, in a schema builder:
    /// Argument.Positional<String>(
    ///     name: "phrase",
    ///     valueName: "phrase",
    ///     arity: .exactly(1),
    ///     visibility: .visible,
    ///     help: .init(abstract: "The phrase to repeat.")
    /// )
    /// ```
    public struct Positional<V: Sendable & Equatable>: Sendable, Equatable {
        /// The schema-side name of this positional (used in diagnostics and help).
        public let name: String
        /// The placeholder rendered in usage lines (e.g., `<phrase>`).
        public let valueName: String
        /// The expected arity (typically `.exactly(1)`).
        public let arity: Argument.Arity
        /// Whether this argument appears in help text.
        public let visibility: Argument.Visibility
        /// Documentation for this positional.
        public let help: Argument.Help

        /// Creates a positional declaration.
        ///
        /// - Parameters:
        ///   - name: The schema-side identifier (used in diagnostics).
        ///   - valueName: The usage-line placeholder (e.g., `phrase`).
        ///   - arity: How many values this positional consumes. Defaults to `.exactly(1)`.
        ///   - visibility: Whether this argument appears in help text. Defaults to `.visible`.
        ///   - help: Documentation for this positional. Defaults to empty.
        @inlinable
        public init(
            name: String,
            valueName: String,
            arity: Argument.Arity = .exactly(1),
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init()
        ) {
            self.name = name
            self.valueName = valueName
            self.arity = arity
            self.visibility = visibility
            self.help = help
        }
    }
}
