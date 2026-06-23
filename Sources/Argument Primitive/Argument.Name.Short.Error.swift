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

extension Argument.Name.Short {
    /// Errors thrown when constructing an `Argument.Name.Short`.
    ///
    /// Per POSIX 12.2 Guideline 3, option names must be single ASCII
    /// alphanumeric characters. The construction of an `Argument.Name.Short`
    /// validates this; invalid characters trip this error.
    public enum Error: Swift.Error, Sendable, Hashable, Equatable {
        /// The character was not a single ASCII alphanumeric.
        case notASCIIAlphanumeric(found: Character)
    }
}
