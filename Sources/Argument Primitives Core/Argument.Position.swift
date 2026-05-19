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
    /// A location in argv addressable for diagnostics.
    ///
    /// Unlike `Source.Position` (which is file-qualified for source-code
    /// diagnostics), `Argument.Position` is argv-qualified: it records
    /// which argv element (by index) and at what byte offset within that
    /// element a diagnostic is anchored.
    ///
    /// ## Examples
    ///
    /// ```swift
    /// // The 3rd argv element, at byte offset 5 (e.g., the 'x' in --foo=x).
    /// let position = Argument.Position(argvIndex: 2, byteOffset: 5)
    /// ```
    public struct Position: Sendable, Hashable, Equatable {
        /// The zero-based argv index (matching `CommandLine.arguments` order).
        public let argvIndex: Int
        /// The zero-based byte offset within that argv element.
        public let byteOffset: Int

        /// Creates an argv position.
        ///
        /// - Parameters:
        ///   - argvIndex: The zero-based argv index.
        ///   - byteOffset: The zero-based byte offset within the argv element.
        @inlinable
        public init(argvIndex: Int, byteOffset: Int) {
            self.argvIndex = argvIndex
            self.byteOffset = byteOffset
        }
    }
}
