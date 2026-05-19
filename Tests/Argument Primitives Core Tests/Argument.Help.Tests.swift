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

extension Argument.Help {
    @Suite("Argument.Help")
    struct Test {
        @Suite struct Unit {
            @Test func `default initializer produces empty fields`() {
                let help = Argument.Help()
                #expect(help.abstract.isEmpty)
                #expect(help.discussion.isEmpty)
                #expect(help.placeholder == nil)
                #expect(help.defaults == nil)
            }

            @Test func `named initializer carries values`() {
                let help = Argument.Help(
                    abstract: "Count",
                    discussion: "The count.",
                    placeholder: "<n>",
                    defaults: "2"
                )
                #expect(help.abstract == "Count")
                #expect(help.discussion == "The count.")
                #expect(help.placeholder == "<n>")
                #expect(help.defaults == "2")
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
