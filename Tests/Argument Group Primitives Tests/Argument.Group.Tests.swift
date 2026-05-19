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

@Suite("Argument.Group")
struct ArgumentGroupTests {

    fileprivate struct Network: Sendable {}

    @Test("initializer carries explicit fields")
    func initializerCarriesExplicitFields() {
        let group = Argument.Group<Network>(
            valueName: "network",
            visibility: .visible,
            help: .init(abstract: "Network configuration.")
        )
        #expect(group.valueName == "network")
        #expect(group.visibility == .visible)
        #expect(group.help.abstract == "Network configuration.")
    }

    @Test("default visibility is visible")
    func defaultVisibilityIsVisible() {
        let group = Argument.Group<Network>(valueName: "network")
        #expect(group.visibility == .visible)
    }
}
