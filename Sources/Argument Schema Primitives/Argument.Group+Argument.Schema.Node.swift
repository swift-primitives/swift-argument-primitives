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

extension Argument.Group: Argument.Schema.Node {
    /// Dispatches this group declaration to the visitor's
    /// `visit(group:)` method, recovering the static group type `G`
    /// at the call site.
    @inlinable
    public func accept<Visitor: Argument.Schema.Visitor>(
        _ visitor: inout Visitor
    ) throws(Visitor.Failure) {
        try visitor.visit(group: self)
    }
}
