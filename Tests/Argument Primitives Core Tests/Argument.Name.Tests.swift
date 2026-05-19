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

@Suite("Argument.Name")
struct ArgumentNameTests {

    @Test("short-only case exposes short, not long")
    func shortOnly() throws(Argument.Name.Short.Error) {
        let name = Argument.Name.short(try .init("v"))
        #expect(name.short?.character == "v")
        #expect(name.long == nil)
    }

    @Test("long-only case exposes long, not short")
    func longOnly() throws(Argument.Name.Long.Error) {
        let name = Argument.Name.long(try .init("verbose"))
        #expect(name.short == nil)
        #expect(name.long?.string == "verbose")
    }

    // reason: mixed-error test — calls both Argument.Name.Short.init and
    // Argument.Name.Long.init which throw distinct typed errors; the
    // function-level untyped throws is the simplest sum at the test site.
    @Test("both case exposes short and long")
    // swiftlint:disable:next typed_throws_required
    func both() throws {
        let name = Argument.Name.both(
            short: try .init("v"),
            long: try .init("verbose")
        )
        #expect(name.short?.character == "v")
        #expect(name.long?.string == "verbose")
    }

    // MARK: - D14 literal-name factories

    @Test("Argument.Name.Long.literal constructs validated long name without try")
    func longLiteralFactory() {
        let name = Argument.Name.Long.literal("verbose")
        #expect(name.string == "verbose")
    }

    @Test("Argument.Name.Short.literal constructs validated short name without try")
    func shortLiteralFactory() {
        let name = Argument.Name.Short.literal("v")
        #expect(name.character == "v")
    }

    @Test("Argument.Name.longLiteral hoists Long.literal to .long(_) case")
    func argumentNameLongLiteral() {
        let name = Argument.Name.longLiteral("count")
        #expect(name.long?.string == "count")
        #expect(name.short == nil)
    }

    @Test("Argument.Name.shortLiteral hoists Short.literal to .short(_) case")
    func argumentNameShortLiteral() {
        let name = Argument.Name.shortLiteral("c")
        #expect(name.short?.character == "c")
        #expect(name.long == nil)
    }

    @Test("Argument.Name.bothLiteral hoists both literals to .both(short:long:)")
    func argumentNameBothLiteral() {
        let name = Argument.Name.bothLiteral(short: "v", long: "verbose")
        #expect(name.short?.character == "v")
        #expect(name.long?.string == "verbose")
    }

    @Test("Argument.Name.Long.literal accepts hyphenated form")
    func longLiteralHyphenated() {
        let name = Argument.Name.Long.literal("dry-run")
        #expect(name.string == "dry-run")
    }

    @Test("Argument.Name.longLiteral produces value usable at production sites")
    func longLiteralProductionUsage() {
        // Production-site shape: declarative, no `try`, no `_unchecked`.
        // Demonstrates the D14 fix — the literal-name pattern composes
        // cleanly with the case-constructor surface.
        let names: [Argument.Name] = [
            .longLiteral("verbose"),
            .shortLiteral("v"),
            .bothLiteral(short: "h", long: "help"),
        ]
        #expect(names.count == 3)
        #expect(names[0].long?.string == "verbose")
        #expect(names[1].short?.character == "v")
        #expect(names[2].short?.character == "h")
        #expect(names[2].long?.string == "help")
    }
}
