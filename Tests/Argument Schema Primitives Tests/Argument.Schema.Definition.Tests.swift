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

private struct Root: Sendable {}

extension Argument.Schema.Definition<Root> {
    @Suite("Argument.Schema.Definition")
    struct Test {
        @Suite struct Unit {
            @Test func `accept walks nodes in declaration order`() throws(Argument.Name.Long.Error) {
                let nodes: [any Argument.Schema.Node] = [
                    Argument.Positional<String>(name: "phrase", placeholder: "phrase"),
                    Argument.Option<Int>(name: .long(try .init("count")), placeholder: "count"),
                    Argument.Flag(name: .long(try .init("verbose"))),
                ]
                let definition = Argument.Schema.Definition<Root>(nodes: nodes)
                var recording = Argument.Schema.Recording()
                definition.accept(&recording)
                #expect(recording.events == [.positional, .option, .flag])
            }

            @Test func `empty schema produces empty event list`() {
                let definition = Argument.Schema.Definition<Root>(nodes: [])
                var recording = Argument.Schema.Recording()
                definition.accept(&recording)
                #expect(recording.events.isEmpty)
            }

            @Test func `schema with all node kinds visits each kind`() throws(Argument.Name.Long.Error) {
                let nodes: [any Argument.Schema.Node] = [
                    Argument.Positional<String>(name: "p", placeholder: "p"),
                    Argument.Option<Int>(name: .long(try .init("o")), placeholder: "o"),
                    Argument.Flag(name: .long(try .init("f"))),
                    Argument.Group<Root>(name: "g"),
                    Argument.Subcommand<Root>(name: "s"),
                ]
                let definition = Argument.Schema.Definition<Root>(nodes: nodes)
                var recording = Argument.Schema.Recording()
                definition.accept(&recording)
                #expect(recording.events == [.positional, .option, .flag, .group, .subcommand])
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
