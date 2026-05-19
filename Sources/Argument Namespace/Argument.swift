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

/// The argument-parsing domain namespace.
///
/// `Argument` is the root of the CLI argument-parsing vocabulary. The
/// namespace owns vocabulary atoms (names, arity, visibility, help,
/// tokens, errors, positions, environment-variable names), schema
/// node types (positional, option, flag, group, subcommand), and the
/// schema-as-data root type.
///
/// Higher layers (L2 standards, L3 foundations) extend this namespace
/// — e.g., L2 `IEEE_1003.UtilitySyntax.Tokenizer` produces an
/// `Argument.Token` stream; L3 `swift-arguments` composes a
/// `Command.Schema<Root>` over `Argument.Schema.Node`-conforming
/// combinators.
///
/// ## Layer
///
/// L1 primitives — Foundation-free vocabulary. No parsing logic at L1;
/// parser-machinery lives at L2 (POSIX 12.2) and L3 (`swift-arguments`).
public enum Argument {}
