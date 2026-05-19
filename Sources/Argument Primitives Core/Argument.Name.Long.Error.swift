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

extension Argument.Name.Long {
    /// Errors thrown when constructing an `Argument.Name.Long`.
    ///
    /// Per GNU long-options convention (§4.8), long option names match
    /// the pattern `[a-zA-Z][a-zA-Z0-9-]*`. The construction of an
    /// `Argument.Name.Long` validates this; invalid strings trip this
    /// error.
    public enum Error: Swift.Error, Sendable, Hashable, Equatable {
        /// The string was empty.
        case empty
        /// The string does not start with an ASCII letter.
        case doesNotStartWithLetter(found: Character)
        /// The string contains a character outside `[a-zA-Z0-9-]`.
        case invalidCharacter(found: Character)
    }
}
