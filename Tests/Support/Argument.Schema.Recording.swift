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
    /// A visitor that records the kind of each visited node.
    ///
    /// Test fixtures verify schema traversal by accepting this visitor
    /// against a `Argument.Schema.Definition` and asserting on the
    /// resulting `events` array.
    ///
    /// ## Example
    ///
    /// ```swift
    /// var visitor = Argument.Schema.Recording()
    /// try definition.accept(&visitor)
    /// #expect(visitor.events == [.positional, .option, .flag])
    /// ```
    public struct Recording: Sendable {
        /// The sequence of events recorded so far.
        public private(set) var events: [Event]

        /// Creates a fresh recording visitor.
        public init() {
            self.events = []
        }
    }
}

extension Argument.Schema.Recording {
    /// A record of one visited node's kind.
    public enum Event: Sendable, Hashable, Equatable {
        case positional
        case option
        case flag
        case group
        case subcommand
    }
}

extension Argument.Schema.Recording: Argument.Schema.Visitor {
    public typealias Failure = Never

    public mutating func visit<V: Sendable & Equatable>(
        positional: Argument.Positional<V>
    ) throws(Never) {
        events.append(.positional)
    }

    public mutating func visit<V: Sendable & Equatable>(
        option: Argument.Option<V>
    ) throws(Never) {
        events.append(.option)
    }

    public mutating func visit(flag: Argument.Flag) throws(Never) {
        events.append(.flag)
    }

    public mutating func visit<G: Sendable>(group: Argument.Group<G>) throws(Never) {
        events.append(.group)
    }

    public mutating func visit<S: Sendable>(
        subcommand: Argument.Subcommand<S>
    ) throws(Never) {
        events.append(.subcommand)
    }
}
