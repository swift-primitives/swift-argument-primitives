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

extension Argument.Position {
    @Suite("Argument.Position")
    struct Test {
        @Suite struct Unit {
            @Test func `initializer carries argvIndex and byteOffset`() {
                let position = Argument.Position(argvIndex: 2, byteOffset: 5)
                #expect(position.argvIndex == 2)
                #expect(position.byteOffset == 5)
            }

            @Test func `equality compares fields`() {
                let a = Argument.Position(argvIndex: 0, byteOffset: 0)
                let b = Argument.Position(argvIndex: 0, byteOffset: 0)
                let c = Argument.Position(argvIndex: 0, byteOffset: 1)
                #expect(a == b)
                #expect(a != c)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
