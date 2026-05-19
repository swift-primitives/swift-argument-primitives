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

// swiftlint:disable no_any_protocol_existential
// reason: schema heterogeneity is load-bearing — each node carries
// a distinct generic value type `V`; no protocol-with-AT shape
// collapses the heterogeneous list. The Visitor's double-dispatch
// via `Node.accept(_:)` recovers the static type per node.
extension Argument.Schema {
    /// The schema-as-data root for a command's argument surface.
    ///
    /// `Argument.Schema.Definition<Root>` is the canonical description
    /// of one command's argument structure. It carries an ordered list
    /// of schema nodes (positionals, options, flags, groups, subcommands)
    /// and the metadata needed for help-text emission, completion-script
    /// generation, manpage rendering, and parser dispatch — all driven
    /// from the same single source of truth per §2.2 of the design.
    ///
    /// `Root` is the type whose fields are populated by the parser. At
    /// L1 the type parameter is structural — the schema declarations
    /// are typed but no parsing logic is wired up. The L3 layer
    /// composes these declarations into a `Parser.Protocol`
    /// implementation that binds parsed values into a `Root` value.
    ///
    /// ## Heterogeneity
    ///
    /// `nodes` is the existential array `Argument.Schema.Node`
    /// (one entry per declared argument) because each `Positional<V>` /
    /// `Option<V>` carries a distinct value type `V`. The visitor's
    /// double-dispatch via `Node.accept(_:)` recovers the static value
    /// type at the call site; the existential is structural, not a
    /// typing loss.
    ///
    /// ## Naming note
    ///
    /// The design doc §3.3 names this type `Argument.Schema<Root>`. At
    /// L1 the name `Schema` is reserved as a namespace owning the `Node`
    /// and `Visitor` protocols (matching the verified spike at
    /// `Experiments/argv-parser-protocol-spike/`); the schema-as-data
    /// container is therefore `Argument.Schema.Definition<Root>`. L3's
    /// `Command.Schema<Root>` (per §3.5) is a separate type at a
    /// different layer; the L1 namespace shape does not collide.
    public struct Definition<Root: Sendable>: Sendable {
        /// The argument-schema nodes that make up this command's surface.
        public let nodes: [any Argument.Schema.Node]

        /// Creates a schema definition from an ordered list of nodes.
        ///
        /// - Parameter nodes: The argument-schema nodes, in declaration
        ///   order. Order matters for positional binding: positionals
        ///   are bound left-to-right in their schema-declared order.
        @inlinable
        public init(nodes: [any Argument.Schema.Node]) {
            self.nodes = nodes
        }

        /// Walks every node in declaration order, dispatching each to
        /// the visitor's typed `visit(...)` method via `Node.accept(_:)`.
        ///
        /// This is the single entry point that help / completion /
        /// manpage / parse-dispatch visitors share. Per §2.2's
        /// bidirectionality, the same definition instance drives both
        /// directions (parse and emit).
        @inlinable
        public func accept<Visitor: Argument.Schema.Visitor>(
            _ visitor: inout Visitor
        ) throws(Visitor.Failure) {
            for node in nodes {
                try node.accept(&visitor)
            }
        }
    }
}
// swiftlint:enable no_any_protocol_existential
