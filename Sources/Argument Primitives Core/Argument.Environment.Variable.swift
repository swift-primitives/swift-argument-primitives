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

extension Argument.Environment {
    /// The environment-variable sub-namespace.
    ///
    /// Owns the typed-identifier `Name`. Variable values, snapshots, and
    /// reads are L3 concerns owned by `swift-environment` and composed
    /// at `swift-arguments`.
    public enum Variable {}
}
