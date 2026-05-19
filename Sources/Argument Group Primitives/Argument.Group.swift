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
    /// A composable group of arguments declared as a sub-schema of type `G`.
    ///
    /// Mirrors swift-argument-parser's `@OptionGroup` property wrapper: a
    /// declaration that pulls in the argument surface of another schema
    /// type (`G`), letting callers compose schemas without flattening
    /// them. The L3 schema-builder dispatches to the child schema's
    /// nodes when walking the parent's surface.
    ///
    /// ## Type parameter
    ///
    /// `G` is the type whose schema is being grouped. The L3 layer
    /// reflects on `G`'s static schema property at schema-build time;
    /// the L1 declaration carries only the metadata needed to render
    /// the group in help and dispatch in parsing.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // At L3:
    /// struct Network {
    ///     static var schema: Command.Schema<Network> { ... }
    /// }
    ///
    /// Argument.Group<Network>(
    ///     name: "network",
    ///     visibility: .visible,
    ///     help: .init(abstract: "Network configuration.")
    /// )
    /// ```
    public struct Group<G: Sendable>: Sendable {
        /// The schema-side identifier (used in diagnostics).
        public let name: String
        /// Whether this group's heading appears in help text.
        public let visibility: Argument.Visibility
        /// Documentation for this group.
        public let help: Argument.Help

        /// Creates a group declaration.
        ///
        /// - Parameters:
        ///   - name: The schema-side identifier.
        ///   - visibility: Whether this group appears in help text. Defaults to `.visible`.
        ///   - help: Documentation. Defaults to empty.
        @inlinable
        public init(
            name: String,
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init()
        ) {
            self.name = name
            self.visibility = visibility
            self.help = help
        }
    }
}
