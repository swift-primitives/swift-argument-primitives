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
    /// The schema namespace.
    ///
    /// Owns the `Node` and `Visitor` protocols plus the `Definition<Root>`
    /// schema-as-data value type. Schemas describe one command's argument
    /// surface (positionals, options, flags, groups, subcommands) and
    /// drive parse, help-text emission, completion emission, and
    /// manpage emission from the same single source of truth per §2.2
    /// of the design.
    public enum Schema {}
}
