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
public import Text_Primitives

extension Argument {
    /// A classified argv token after L2 tokenization.
    ///
    /// `Argument.Token` is the post-tokenization view of a single argv
    /// element: an `Argument.Token.Kind` payload plus the byte-range
    /// within the source argv string. L2 tokenizers (POSIX 12.2, GNU
    /// long-options) emit a stream of these to L3 schema-bound parsers.
    ///
    /// ## Range semantics
    ///
    /// `range` is a `Text.Range` over the original argv-string bytes.
    /// When an L2 tokenizer fuses multiple argv elements (e.g.,
    /// concatenates them for a re-tokenizing pass), `range` reflects the
    /// position in the fused stream; consumers needing per-argv-index
    /// granularity should attach an `Argument.Position` separately at
    /// the parser layer.
    public struct Token: Sendable, Hashable, Equatable {
        /// The semantic kind of this token.
        public let kind: Argument.Token.Kind
        /// The byte range in the original argv source string.
        public let range: Text.Range

        /// Creates a token with the given kind and source range.
        @inlinable
        public init(kind: Argument.Token.Kind, range: Text.Range) {
            self.kind = kind
            self.range = range
        }
    }
}
