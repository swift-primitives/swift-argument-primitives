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

extension Argument.Subcommand {
    /// A list of subcommand declarations evaluated as a `OneOf`-style choice.
    ///
    /// `Argument.Subcommand.Choice` is the declaration-side container
    /// holding the set of subcommands a command supports. Semantically,
    /// the choice maps to `Parser.OneOf` at L3: the L3 schema parser
    /// tries each subcommand declaration in order, succeeding on the
    /// first whose name matches the current argv element.
    ///
    /// The L3 schema builder uses this type's declarations to (a) form
    /// the actual `Parser.OneOf` over the subcommand sum-type and (b)
    /// drive help-text emission listing the available subcommands.
    ///
    /// ## Example
    ///
    /// ```swift
    /// Argument.Subcommand<MyCommand.Subcommand>.Choice(declarations: [
    ///     Argument.Subcommand(name: "push", help: .init(abstract: "Push.")),
    ///     Argument.Subcommand(name: "pull", help: .init(abstract: "Pull.")),
    /// ])
    /// ```
    public struct Choice: Sendable {
        /// The available subcommand declarations.
        public let declarations: [Argument.Subcommand<S>]

        /// Creates a subcommand choice.
        ///
        /// - Parameter declarations: The subcommand declarations to choose among.
        @inlinable
        public init(declarations: [Argument.Subcommand<S>]) {
            self.declarations = declarations
        }
    }
}
