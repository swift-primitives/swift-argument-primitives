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
    /// A single argument-schema node — one declaration in a command's surface.
    ///
    /// `Argument.Schema.Node` is the existential interface that lets a
    /// heterogeneous list of typed schema declarations
    /// (`Positional<String>`, `Option<Int>`, `Flag`, …) be held in one
    /// array. Each conformer implements `accept(_:)` to dispatch to the
    /// visitor's appropriately-typed `visit(...)` method, recovering
    /// the static value type at the visit site (double dispatch).
    ///
    /// ## Conformance
    ///
    /// `Positional`, `Option`, `Flag`, `Group`, and `Subcommand` each
    /// conform via single-line accept implementations in this target.
    public protocol Node: Sendable {
        /// Dispatches this node to the visitor's matching `visit(...)` method.
        ///
        /// - Parameter visitor: The visitor receiving the typed dispatch.
        /// - Throws: Any error the visitor surfaces (`V.Failure`).
        func accept<V: Argument.Schema.Visitor>(_ visitor: inout V) throws(V.Failure)
    }
}
