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

@Suite("Argument.Help")
struct ArgumentHelpTests {

    @Test("default initializer produces empty fields")
    func defaultInitProducesEmptyFields() {
        let help = Argument.Help()
        #expect(help.abstract.isEmpty)
        #expect(help.discussion.isEmpty)
        #expect(help.valueDescription == nil)
        #expect(help.defaultDescription == nil)
    }

    @Test("named initializer carries values")
    func namedInitCarriesValues() {
        let help = Argument.Help(
            abstract: "Count",
            discussion: "The count.",
            valueDescription: "<n>",
            defaultDescription: "2"
        )
        #expect(help.abstract == "Count")
        #expect(help.discussion == "The count.")
        #expect(help.valueDescription == "<n>")
        #expect(help.defaultDescription == "2")
    }
}
