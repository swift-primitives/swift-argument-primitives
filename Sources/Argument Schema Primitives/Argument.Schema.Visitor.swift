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

extension Argument.Schema {
    /// A visitor over the nodes of an `Argument.Schema`.
    ///
    /// Implementations receive value-typed dispatch from each
    /// `Argument.Schema.Node` (via `Node.accept(_:)`) and produce some
    /// artifact: help text, completion script, manpage, or a parse
    /// configuration. The visitor protocol is the structural anchor
    /// for §2.2's bidirectionality — the same schema instance drives
    /// every emission direction.
    ///
    /// ## Failure
    ///
    /// `Failure` defaults to `Never` (pure-text emitters typically can't
    /// fail). Visitors that compose with throwing infrastructure (e.g.,
    /// a parser-config builder that validates cross-field constraints
    /// at build time) override `Failure` to a domain-specific
    /// `Swift.Error`.
    public protocol Visitor {
        /// The error this visitor surfaces.
        ///
        /// Defaults to `Never`.
        associatedtype Failure: Swift.Error = Never

        /// Visit a positional argument declaration.
        mutating func visit<V: Sendable & Equatable>(
            positional: Argument.Positional<V>
        ) throws(Failure)

        /// Visit a named-option declaration.
        mutating func visit<V: Sendable & Equatable>(
            option: Argument.Option<V>
        ) throws(Failure)

        /// Visit a boolean-flag declaration.
        mutating func visit(flag: Argument.Flag) throws(Failure)

        /// Visit a sub-schema group declaration.
        mutating func visit<G: Sendable>(group: Argument.Group<G>) throws(Failure)

        /// Visit a subcommand declaration.
        mutating func visit<S: Sendable>(
            subcommand: Argument.Subcommand<S>
        ) throws(Failure)
    }
}
