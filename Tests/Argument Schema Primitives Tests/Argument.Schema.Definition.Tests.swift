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

@Suite("Argument.Schema.Definition")
struct ArgumentSchemaDefinitionTests {

    fileprivate struct Root: Sendable {}

    @Test("accept walks nodes in declaration order")
    func acceptWalksNodesInDeclarationOrder() throws(Argument.Name.Long.Error) {
        let nodes: [any Argument.Schema.Node] = [
            Argument.Positional<String>(name: "phrase", valueName: "phrase"),
            Argument.Option<Int>(name: .long(try .init("count")), valueName: "count"),
            Argument.Flag(name: .long(try .init("verbose"))),
        ]
        let definition = Argument.Schema.Definition<Root>(nodes: nodes)
        var recording = Argument.Schema.Recording()
        definition.accept(&recording)
        #expect(recording.events == [.positional, .option, .flag])
    }

    @Test("empty schema produces empty event list")
    func emptyScheme() {
        let definition = Argument.Schema.Definition<Root>(nodes: [])
        var recording = Argument.Schema.Recording()
        definition.accept(&recording)
        #expect(recording.events.isEmpty)
    }

    @Test("schema with all node kinds visits each kind")
    func allKinds() throws(Argument.Name.Long.Error) {
        let nodes: [any Argument.Schema.Node] = [
            Argument.Positional<String>(name: "p", valueName: "p"),
            Argument.Option<Int>(name: .long(try .init("o")), valueName: "o"),
            Argument.Flag(name: .long(try .init("f"))),
            Argument.Group<Root>(valueName: "g"),
            Argument.Subcommand<Root>(name: "s"),
        ]
        let definition = Argument.Schema.Definition<Root>(nodes: nodes)
        var recording = Argument.Schema.Recording()
        definition.accept(&recording)
        #expect(recording.events == [.positional, .option, .flag, .group, .subcommand])
    }
}
