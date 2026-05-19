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

// Test Support spine ([MOD-024]).
//
// Anchors on the lowest upstream Test Support module reachable through
// the package's product deps — `Tagged Primitives Test Support`. The
// Tagged TS spine carries `ExpressibleBy*Literal` conformances on
// `Tagged` via its SLI re-export; test files writing
// `let n: Argument.Environment.Variable.Name = "MY_VAR"` inherit that
// ergonomics through this re-export chain.
@_exported public import Argument_Primitives
@_exported public import Tagged_Primitives_Test_Support
