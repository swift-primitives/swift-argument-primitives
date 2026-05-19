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

@Suite("Argument.Flag")
struct ArgumentFlagTests {

    @Test("initializer carries explicit fields")
    func initializerCarriesExplicitFields() throws(Argument.Name.Long.Error) {
        let flag = Argument.Flag(
            name: .long(try .init("verbose")),
            arity: .atMost(1),
            visibility: .visible,
            help: .init(abstract: "Verbose output.")
        )
        #expect(flag.arity == .atMost(1))
        #expect(flag.visibility == .visible)
        #expect(flag.help.abstract == "Verbose output.")
    }

    @Test("default arity is atMost(1)")
    func defaultArityIsAtMostOne() throws(Argument.Name.Long.Error) {
        let flag = Argument.Flag(name: .long(try .init("verbose")))
        #expect(flag.arity == .atMost(1))
    }

    @Test("count arity supports verbosity-style flag")
    func countArityForVerbosity() throws(Argument.Name.Short.Error) {
        let flag = Argument.Flag(
            name: .short(try .init("v")),
            arity: .count
        )
        #expect(flag.arity == .count)
    }
}
