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

@Suite("Argument.Token")
struct ArgumentTokenTests {

    @Test("initializer carries kind and range")
    func initializerCarriesKindAndRange() {
        let start: Text.Position = 0
        let end: Text.Position = 6
        let range = Text.Range(start: start, end: end)
        let token = Argument.Token(kind: .long("verbose"), range: range)
        #expect(token.kind == .long("verbose"))
        #expect(token.range == range)
    }

    @Test("kind cases distinct")
    func kindCasesDistinct() {
        let long: Argument.Token.Kind = .long("foo")
        let short: Argument.Token.Kind = .shortCluster("xyz")
        let value: Argument.Token.Kind = .value("v")
        let separator: Argument.Token.Kind = .separator
        let positional: Argument.Token.Kind = .positional("path")
        let eoo: Argument.Token.Kind = .endOfOptions
        #expect(long != short)
        #expect(value != positional)
        #expect(separator != eoo)
    }
}
