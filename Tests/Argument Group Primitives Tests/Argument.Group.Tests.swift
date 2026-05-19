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

fileprivate struct Network: Sendable {}

extension Argument.Group<Network> {
    @Suite("Argument.Group")
    struct Test {
        @Suite struct Unit {
            @Test func `initializer carries explicit fields`() {
                let group = Argument.Group<Network>(
                    valueName: "network",
                    visibility: .visible,
                    help: .init(abstract: "Network configuration.")
                )
                #expect(group.valueName == "network")
                #expect(group.visibility == .visible)
                #expect(group.help.abstract == "Network configuration.")
            }

            @Test func `default visibility is visible`() {
                let group = Argument.Group<Network>(valueName: "network")
                #expect(group.visibility == .visible)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
