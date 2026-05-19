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

extension Argument.Subcommand: Argument.Schema.Node {
    /// Dispatches this subcommand declaration to the visitor's
    /// `visit(subcommand:)` method, recovering the static subcommand
    /// result type `S` at the call site.
    @inlinable
    public func accept<Visitor: Argument.Schema.Visitor>(
        _ visitor: inout Visitor
    ) throws(Visitor.Failure) {
        try visitor.visit(subcommand: self)
    }

    /// Non-throwing specialization for visitors that cannot fail.
    /// Duplicate body per [IMPL-042] — forwarding does not specialize.
    @inlinable
    public func accept<Visitor: Argument.Schema.Visitor>(
        _ visitor: inout Visitor
    ) where Visitor.Failure == Never {
        visitor.visit(subcommand: self)
    }
}
