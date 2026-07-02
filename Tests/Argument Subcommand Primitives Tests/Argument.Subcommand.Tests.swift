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

private struct PushResult: Sendable {}

private enum Result: Sendable {
    case push
    case pull
}

extension Argument.Subcommand<PushResult> {
    @Suite("Argument.Subcommand")
    struct Test {
        @Suite struct Unit {
            @Test func `initializer carries explicit fields`() {
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

            @Test func `default aliases is empty`() {
                let subcommand = Argument.Subcommand<PushResult>(name: "push")
                #expect(subcommand.aliases.isEmpty)
            }

            @Test func `default visibility is visible`() {
                let subcommand = Argument.Subcommand<PushResult>(name: "push")
                #expect(subcommand.visibility == .visible)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}

extension Argument.Subcommand<Result>.Choice {
    @Suite("Argument.Subcommand.Choice")
    struct Test {
        @Suite struct Unit {
            @Test func `declarations stored in declared order`() {
                let choice = Argument.Subcommand<Result>.Choice(declarations: [
                    .init(name: "push"),
                    .init(name: "pull"),
                ])
                #expect(choice.declarations.count == 2)
                #expect(choice.declarations[0].name == "push")
                #expect(choice.declarations[1].name == "pull")
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
