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

extension Argument.Positional<String> {
    @Suite("Argument.Positional")
    struct Test {
        @Suite struct Unit {
            @Test func `initializer carries explicit fields`() {
                let positional = Argument.Positional<String>(
                    name: "phrase",
                    placeholder: "phrase",
                    arity: .exactly(1),
                    visibility: .visible,
                    help: .init(abstract: "The phrase to repeat.")
                )
                #expect(positional.name == "phrase")
                #expect(positional.placeholder == "phrase")
                #expect(positional.arity == .exactly(1))
                #expect(positional.visibility == .visible)
                #expect(positional.help.abstract == "The phrase to repeat.")
            }

            @Test func `default arity is exactly(1)`() {
                let positional = Argument.Positional<String>(name: "x", placeholder: "x")
                #expect(positional.arity == .exactly(1))
            }

            @Test func `default visibility is visible`() {
                let positional = Argument.Positional<String>(name: "x", placeholder: "x")
                #expect(positional.visibility == .visible)
            }

            @Test func `generic over Int value type`() {
                let positional = Argument.Positional<Int>(name: "count", placeholder: "count")
                #expect(positional.name == "count")
            }

            @Test func equatable() {
                let a = Argument.Positional<String>(name: "x", placeholder: "x")
                let b = Argument.Positional<String>(name: "x", placeholder: "x")
                let c = Argument.Positional<String>(name: "y", placeholder: "x")
                #expect(a == b)
                #expect(a != c)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
