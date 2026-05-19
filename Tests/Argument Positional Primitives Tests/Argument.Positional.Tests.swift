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

@Suite("Argument.Positional")
struct ArgumentPositionalTests {

    @Test("initializer carries explicit fields")
    func initializerCarriesExplicitFields() {
        let positional = Argument.Positional<String>(
            name: "phrase",
            valueName: "phrase",
            arity: .exactly(1),
            visibility: .visible,
            help: .init(abstract: "The phrase to repeat.")
        )
        #expect(positional.name == "phrase")
        #expect(positional.valueName == "phrase")
        #expect(positional.arity == .exactly(1))
        #expect(positional.visibility == .visible)
        #expect(positional.help.abstract == "The phrase to repeat.")
    }

    @Test("default arity is exactly(1)")
    func defaultArityIsExactlyOne() {
        let positional = Argument.Positional<String>(name: "x", valueName: "x")
        #expect(positional.arity == .exactly(1))
    }

    @Test("default visibility is visible")
    func defaultVisibilityIsVisible() {
        let positional = Argument.Positional<String>(name: "x", valueName: "x")
        #expect(positional.visibility == .visible)
    }

    @Test("generic over Int value type")
    func genericOverIntValueType() {
        let positional = Argument.Positional<Int>(name: "count", valueName: "count")
        #expect(positional.name == "count")
    }

    @Test("equatable")
    func equatable() {
        let a = Argument.Positional<String>(name: "x", valueName: "x")
        let b = Argument.Positional<String>(name: "x", valueName: "x")
        let c = Argument.Positional<String>(name: "y", valueName: "x")
        #expect(a == b)
        #expect(a != c)
    }
}
