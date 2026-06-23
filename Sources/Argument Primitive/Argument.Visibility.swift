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
    /// Whether an argument appears in help text.
    ///
    /// `Visibility` lets a schema include internal or experimental
    /// arguments without polluting the user-facing help text. The
    /// argument still parses; it just is not advertised.
    public enum Visibility: Sendable, Hashable, Equatable {
        /// The argument appears in help text.
        case visible
        /// The argument is parsed but hidden from help text.
        case hidden
    }
}
