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

public import Argument_Primitive
public import Byte_Primitives
public import Index_Primitives

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
        ///
        /// Phantom-typed by `String` (the argv element type) for compile-time
        /// domain safety: an `Index<String>` cannot be confused with indices
        /// into other collections.
        public let argvIndex: Index<String>

        /// The zero-based byte offset within that argv element.
        ///
        /// Phantom-typed by `Byte` (the institute's byte-domain marker, per
        /// `byte-protocol-capability-marker.md` Q1=Option B). `Byte` is the
        /// byte-domain twin of `UInt8` (the arithmetic-algebras type); using
        /// `Byte` as the tag aligns this displacement with the byte-domain
        /// identity discipline. `Index<Byte>.Offset` is
        /// `Tagged<Byte, Affine.Discrete.Vector>` (signed byte displacement).
        public let byteOffset: Index<Byte>.Offset

        /// Creates an argv position.
        ///
        /// - Parameters:
        ///   - argvIndex: The zero-based argv index.
        ///   - byteOffset: The zero-based byte offset within the argv element.
        @inlinable
        public init(argvIndex: Index<String>, byteOffset: Index<Byte>.Offset) {
            self.argvIndex = argvIndex
            self.byteOffset = byteOffset
        }
    }
}
