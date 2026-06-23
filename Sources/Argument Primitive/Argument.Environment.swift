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
    /// The process-environment sub-namespace.
    ///
    /// `Argument.Environment` collects vocabulary types for process
    /// environment variables used by L3 schemas as fallback value
    /// sources (cmdline > env > defaults). At L1 the namespace contains
    /// only the `Variable.Name` typed-identifier; L3 packages compose
    /// reads, snapshots, and overlays.
    public enum Environment {}
}
