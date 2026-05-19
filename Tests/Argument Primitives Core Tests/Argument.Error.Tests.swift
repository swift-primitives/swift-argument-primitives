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

@Suite("Argument.Error")
struct ArgumentErrorTests {

    @Test("position accessor returns the case's position payload")
    func positionAccessor() {
        let position = Argument.Position(argvIndex: 1, byteOffset: 0)
        let error = Argument.Error.unknownOption(name: "--foo", position: position)
        #expect(error.position == position)
    }

    @Test("severity is .error by default for all cases")
    func severityIsError() {
        let position = Argument.Position(argvIndex: 0, byteOffset: 0)
        let cases: [Argument.Error] = [
            .unknownOption(name: "--foo", position: position),
            .missingValue(name: "--foo", position: position),
            .invalidValue(name: "--foo", value: "x", position: position),
            .missingPositional(name: "phrase", position: position),
            .unexpectedPositional(value: "x", position: position),
            .missingSubcommand(position: position),
            .unknownSubcommand(name: "x", position: position),
            .validationFailed(reason: "x", position: position),
        ]
        for error in cases {
            #expect(error.severity == .error)
        }
    }
}
