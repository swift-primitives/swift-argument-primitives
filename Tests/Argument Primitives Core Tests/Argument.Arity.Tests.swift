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

@Suite("Argument.Arity")
struct ArgumentArityTests {

    @Test("cases distinct")
    func casesDistinct() {
        let exact: Argument.Arity = .exactly(1)
        let atMost: Argument.Arity = .atMost(2)
        let atLeast: Argument.Arity = .atLeast(0)
        let range: Argument.Arity = .range(1...3)
        let count: Argument.Arity = .count
        #expect(exact != atMost)
        #expect(exact != atLeast)
        #expect(exact != range)
        #expect(exact != count)
    }

    @Test("range equality")
    func rangeEquality() {
        let a: Argument.Arity = .range(1...3)
        let b: Argument.Arity = .range(1...3)
        let c: Argument.Arity = .range(0...3)
        #expect(a == b)
        #expect(a != c)
    }
}
