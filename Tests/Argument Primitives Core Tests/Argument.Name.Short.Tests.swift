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

@Suite("Argument.Name.Short")
struct ArgumentNameShortTests {

    @Test("accepts ASCII letter")
    func acceptsASCIILetter() throws(Argument.Name.Short.Error) {
        let name = try Argument.Name.Short("f")
        #expect(name.character == "f")
    }

    @Test("accepts ASCII digit")
    func acceptsASCIIDigit() throws(Argument.Name.Short.Error) {
        let name = try Argument.Name.Short("3")
        #expect(name.character == "3")
    }

    @Test("accepts ASCII uppercase letter")
    func acceptsASCIIUppercaseLetter() throws(Argument.Name.Short.Error) {
        let name = try Argument.Name.Short("F")
        #expect(name.character == "F")
    }

    @Test("rejects non-ASCII letter")
    func rejectsNonASCII() {
        #expect(throws: Argument.Name.Short.Error.notASCIIAlphanumeric(found: "ø")) {
            _ = try Argument.Name.Short("ø")
        }
    }

    @Test("rejects punctuation")
    func rejectsPunctuation() {
        #expect(throws: Argument.Name.Short.Error.notASCIIAlphanumeric(found: "-")) {
            _ = try Argument.Name.Short("-")
        }
    }

    @Test("unchecked initializer bypasses validation")
    func uncheckedInitBypassesValidation() {
        let name = Argument.Name.Short(_unchecked: "ø")
        #expect(name.character == "ø")
    }

    // MARK: - D14 literal factory

    @Test("literal factory constructs validated character without try")
    func literalFactoryAcceptsValid() {
        let name = Argument.Name.Short.literal("v")
        #expect(name.character == "v")
    }

    @Test("literal factory accepts ASCII digit")
    func literalFactoryAcceptsDigit() {
        let name = Argument.Name.Short.literal("3")
        #expect(name.character == "3")
    }

    @Test("literal factory accepts uppercase letter")
    func literalFactoryAcceptsUppercase() {
        let name = Argument.Name.Short.literal("F")
        #expect(name.character == "F")
    }
}
