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

extension Argument.Environment.Variable {
    /// A process environment-variable name (e.g., `"MYAPP_VERBOSITY"`).
    ///
    /// `Name` is `Tagged<Argument.Environment.Variable, String>`: the
    /// containing namespace `Variable` plays the phantom-tag role per
    /// `[API-NAME-010a]`. No validation is performed at L1; L3 packages
    /// composing reads may impose platform-specific naming rules.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// let verbosity: Argument.Environment.Variable.Name = "MYAPP_VERBOSITY"
    /// ```
    public typealias Name = Tagged<Argument.Environment.Variable, String>
}
