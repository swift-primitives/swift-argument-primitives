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

@Suite("Argument.Position")
struct ArgumentPositionTests {

    @Test("initializer carries argvIndex and byteOffset")
    func initializerCarriesFields() {
        let position = Argument.Position(argvIndex: 2, byteOffset: 5)
        #expect(position.argvIndex == 2)
        #expect(position.byteOffset == 5)
    }

    @Test("equality compares fields")
    func equalityComparesFields() {
        let a = Argument.Position(argvIndex: 0, byteOffset: 0)
        let b = Argument.Position(argvIndex: 0, byteOffset: 0)
        let c = Argument.Position(argvIndex: 0, byteOffset: 1)
        #expect(a == b)
        #expect(a != c)
    }
}
