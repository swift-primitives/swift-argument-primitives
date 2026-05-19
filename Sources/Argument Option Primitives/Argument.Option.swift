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
    /// A named option declaration with a parsed value type `V`.
    ///
    /// Declared in a `Command.Schema<Root>` to bind a `--name <value>` or
    /// `-n <value>` argv element to a field on `Root`. Mirrors
    /// swift-argument-parser's `@Option` property wrapper but as a value
    /// type owned by an explicit schema-as-data declaration.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Argument.Option<Int>(
    ///     name: .both(short: try .init("c"), long: try .init("count")),
    ///     valueName: "count",
    ///     arity: .exactly(1),
    ///     visibility: .visible,
    ///     help: .init(abstract: "Number of times to repeat.", defaultDescription: "2")
    /// )
    /// ```
    public struct Option<V: Sendable & Equatable>: Sendable, Equatable {
        /// The option's name (short, long, or both).
        public let name: Argument.Name
        /// The placeholder rendered in usage lines (e.g., `<count>`).
        public let valueName: String
        /// The expected arity (typically `.exactly(1)`).
        public let arity: Argument.Arity
        /// Whether this argument appears in help text.
        public let visibility: Argument.Visibility
        /// Documentation for this option.
        public let help: Argument.Help
        /// An optional default-value source. The L3 environment resolves
        /// the value (defaults, env-var lookup) at parse time.
        public let environmentVariable: Argument.Environment.Variable.Name?

        /// Creates an option declaration.
        ///
        /// - Parameters:
        ///   - name: The option's name forms.
        ///   - valueName: The usage-line placeholder.
        ///   - arity: How many values this option consumes. Defaults to `.exactly(1)`.
        ///   - visibility: Whether this argument appears in help text. Defaults to `.visible`.
        ///   - help: Documentation. Defaults to empty.
        ///   - environmentVariable: Optional env-var fallback name. Defaults to `nil`.
        @inlinable
        public init(
            name: Argument.Name,
            valueName: String,
            arity: Argument.Arity = .exactly(1),
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init(),
            environmentVariable: Argument.Environment.Variable.Name? = nil
        ) {
            self.name = name
            self.valueName = valueName
            self.arity = arity
            self.visibility = visibility
            self.help = help
            self.environmentVariable = environmentVariable
        }
    }
}
