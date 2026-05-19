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
    /// Documentation associated with an argument.
    ///
    /// `Help` carries the descriptive text emitted by help-text serializers
    /// at L3. The schema layer attaches a `Help` to each `Positional` /
    /// `Option` / `Flag` declaration; visitors at L3 read these fields
    /// to produce `--help` output, manpages, and shell-completion docs.
    ///
    /// ## Fields
    ///
    /// - `abstract` — one-line summary (required at the call site, but
    ///   `""` is permitted).
    /// - `discussion` — multi-paragraph extended description.
    /// - `placeholder` — placeholder in usage lines (e.g.,
    ///   `<count>` for `--count <count>`).
    /// - `defaults` — rendered representation of the default
    ///   value, if any. When `nil`, the schema may emit a default
    ///   computed from the value via `String(describing:)`.
    public struct Help: Sendable, Hashable, Equatable {
        /// One-line summary.
        public let abstract: String
        /// Multi-paragraph extended description.
        public let discussion: String
        /// Placeholder rendering for value-bearing arguments.
        public let placeholder: String?
        /// Rendered representation of the default value, if any.
        public let defaults: String?

        /// Creates a `Help` descriptor.
        @inlinable
        public init(
            abstract: String = "",
            discussion: String = "",
            placeholder: String? = nil,
            defaults: String? = nil
        ) {
            self.abstract = abstract
            self.discussion = discussion
            self.placeholder = placeholder
            self.defaults = defaults
        }
    }
}
