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

@Suite("Argument.Visibility")
struct ArgumentVisibilityTests {

    @Test("cases distinct")
    func casesDistinct() {
        #expect(Argument.Visibility.visible != Argument.Visibility.hidden)
    }
}
