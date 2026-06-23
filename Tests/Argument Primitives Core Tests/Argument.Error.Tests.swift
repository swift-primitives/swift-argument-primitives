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
import Diagnostic_Primitives

@testable import Argument_Primitives_Test_Support

extension Argument.Error {
    @Suite("Argument.Error")
    struct Test {
        @Suite struct Unit {
            @Test func `position accessor returns the case's position payload`() {
                let position = Argument.Position(argvIndex: 1, byteOffset: 0)
                let error = Argument.Error.unknownOption(name: "--foo", position: position)
                // swift-linter:disable:next raw value access
                // REASON: `.position` is the case-payload accessor on Argument.Error, not a brand-newtype rawValue. [PATTERN-017] recognizer collides on the field-name shape; same-package use is the rule's documented legitimate case.
                #expect(error.position == position)
            }

            @Test func `severity is .error by default for all cases`() {
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

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
