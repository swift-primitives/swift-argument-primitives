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

@Suite("Argument.Subcommand")
struct ArgumentSubcommandTests {

    fileprivate struct PushResult: Sendable {}

    @Test("initializer carries explicit fields")
    func initializerCarriesExplicitFields() {
        let subcommand = Argument.Subcommand<PushResult>(
            name: "push",
            aliases: ["p"],
            visibility: .visible,
            help: .init(abstract: "Push.")
        )
        #expect(subcommand.name == "push")
        #expect(subcommand.aliases == ["p"])
        #expect(subcommand.visibility == .visible)
        #expect(subcommand.help.abstract == "Push.")
    }

    @Test("default aliases is empty")
    func defaultAliasesIsEmpty() {
        let subcommand = Argument.Subcommand<PushResult>(name: "push")
        #expect(subcommand.aliases.isEmpty)
    }

    @Test("default visibility is visible")
    func defaultVisibilityIsVisible() {
        let subcommand = Argument.Subcommand<PushResult>(name: "push")
        #expect(subcommand.visibility == .visible)
    }
}

@Suite("Argument.Subcommand.Choice")
struct ArgumentSubcommandChoiceTests {

    fileprivate enum Result: Sendable {
        case push
        case pull
    }

    @Test("declarations stored in declared order")
    func declarationsStoredInDeclaredOrder() {
        let choice = Argument.Subcommand<Result>.Choice(declarations: [
            .init(name: "push"),
            .init(name: "pull"),
        ])
        #expect(choice.declarations.count == 2)
        #expect(choice.declarations[0].name == "push")
        #expect(choice.declarations[1].name == "pull")
    }
}
