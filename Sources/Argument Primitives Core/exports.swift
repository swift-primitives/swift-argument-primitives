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

// DEPRECATED — transitional shim (L1 core-dissolution sweep 2026-06-23). Re-exports the dissolved Core surface; removed in the cleanup wave.

// Relocated declarations: root + the sub-namespaces that received Core's
// external-dep-bearing decls.
@_exported public import Argument_Primitive
@_exported public import Argument_Position_Primitives
@_exported public import Argument_Error_Primitives
@_exported public import Argument_Environment_Primitives
@_exported public import Argument_Token_Primitives

// Funneled externals: every module the pre-migration Core re-exported, so
// consumers relying on Core's re-exported externals keep resolving.
@_exported public import Tagged_Primitives
@_exported public import Text_Primitives
@_exported public import Diagnostic_Primitives
@_exported public import Index_Primitives
@_exported public import Affine_Primitives
@_exported public import Byte_Primitives
