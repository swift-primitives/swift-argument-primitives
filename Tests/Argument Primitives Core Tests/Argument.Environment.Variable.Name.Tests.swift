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

import Testing

@testable import Argument_Primitives_Test_Support

@Suite("Argument.Environment.Variable.Name")
struct ArgumentEnvironmentVariableNameTests {

    @Test("constructs from string literal via Tagged SLI")
    func constructsFromStringLiteral() {
        let name: Argument.Environment.Variable.Name = "MYAPP_VERBOSITY"
        #expect(name.underlying == "MYAPP_VERBOSITY")
    }

    @Test("two names with same underlying are equal")
    func equality() {
        let a: Argument.Environment.Variable.Name = "FOO"
        let b: Argument.Environment.Variable.Name = "FOO"
        #expect(a == b)
    }
}
