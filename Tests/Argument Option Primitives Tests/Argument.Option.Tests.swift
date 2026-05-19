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

@Suite("Argument.Option")
struct ArgumentOptionTests {

    // reason: mixed-error test — Short.init and Long.init throw distinct typed errors.
    @Test("initializer carries explicit fields")
    // swiftlint:disable:next typed_throws_required
    func initializerCarriesExplicitFields() throws {
        let option = Argument.Option<Int>(
            name: .both(short: try .init("c"), long: try .init("count")),
            valueName: "count",
            arity: .exactly(1),
            visibility: .visible,
            help: .init(abstract: "Repeat count.", defaultDescription: "2")
        )
        #expect(option.valueName == "count")
        #expect(option.arity == .exactly(1))
        #expect(option.visibility == .visible)
        #expect(option.help.abstract == "Repeat count.")
        #expect(option.help.defaultDescription == "2")
    }

    @Test("default arity is exactly(1)")
    func defaultArityIsExactlyOne() throws(Argument.Name.Long.Error) {
        let option = Argument.Option<Int>(
            name: .long(try .init("count")),
            valueName: "count"
        )
        #expect(option.arity == .exactly(1))
    }

    @Test("environment variable defaults to nil")
    func environmentVariableDefaultsToNil() throws(Argument.Name.Long.Error) {
        let option = Argument.Option<Int>(
            name: .long(try .init("count")),
            valueName: "count"
        )
        #expect(option.environmentVariable == nil)
    }

    @Test("environment variable carries name when supplied")
    func environmentVariableCarriesName() throws(Argument.Name.Long.Error) {
        let varName: Argument.Environment.Variable.Name = "MYAPP_COUNT"
        let option = Argument.Option<Int>(
            name: .long(try .init("count")),
            valueName: "count",
            environmentVariable: varName
        )
        #expect(option.environmentVariable == varName)
    }
}
