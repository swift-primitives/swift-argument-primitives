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

@Suite("Argument.Name.Long")
struct ArgumentNameLongTests {

    @Test("accepts simple letter sequence")
    func acceptsSimpleLetterSequence() throws(Argument.Name.Long.Error) {
        let name = try Argument.Name.Long("verbose")
        #expect(name.string == "verbose")
    }

    @Test("accepts hyphenated form")
    func acceptsHyphenated() throws(Argument.Name.Long.Error) {
        let name = try Argument.Name.Long("dry-run")
        #expect(name.string == "dry-run")
    }

    @Test("accepts letter followed by digits")
    func acceptsLetterFollowedByDigits() throws(Argument.Name.Long.Error) {
        let name = try Argument.Name.Long("v2")
        #expect(name.string == "v2")
    }

    @Test("rejects empty string")
    func rejectsEmpty() {
        #expect(throws: Argument.Name.Long.Error.empty) {
            _ = try Argument.Name.Long("")
        }
    }

    @Test("rejects leading digit")
    func rejectsLeadingDigit() {
        #expect(throws: Argument.Name.Long.Error.doesNotStartWithLetter(found: "9")) {
            _ = try Argument.Name.Long("9lives")
        }
    }

    @Test("rejects underscore")
    func rejectsUnderscore() {
        #expect(throws: Argument.Name.Long.Error.invalidCharacter(found: "_")) {
            _ = try Argument.Name.Long("dry_run")
        }
    }

    @Test("rejects non-ASCII character")
    func rejectsNonASCII() {
        #expect(throws: Argument.Name.Long.Error.invalidCharacter(found: "ø")) {
            _ = try Argument.Name.Long("nøde")
        }
    }

    // MARK: - D14 literal factory

    @Test("literal factory constructs validated name without try")
    func literalFactoryAcceptsValid() {
        let name = Argument.Name.Long.literal("verbose")
        #expect(name.string == "verbose")
    }

    @Test("literal factory accepts hyphenated form")
    func literalFactoryHyphenated() {
        let name = Argument.Name.Long.literal("dry-run")
        #expect(name.string == "dry-run")
    }

    @Test("literal factory accepts letter-followed-by-digits")
    func literalFactoryLetterDigit() {
        let name = Argument.Name.Long.literal("v2")
        #expect(name.string == "v2")
    }
}
