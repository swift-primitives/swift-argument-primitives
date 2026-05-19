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

extension Argument.Visibility {
    @Suite("Argument.Visibility")
    struct Test {
        @Suite struct Unit {
            @Test func `cases distinct`() {
                #expect(Argument.Visibility.visible != Argument.Visibility.hidden)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
