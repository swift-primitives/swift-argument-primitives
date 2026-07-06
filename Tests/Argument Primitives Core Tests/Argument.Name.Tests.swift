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

extension Argument.Name {
    @Suite("Argument.Name")
    struct Test {
        @Suite struct Unit {
            @Test func `short-only case exposes short, not long`() throws(Argument.Name.Short.Error) {
                let name = Argument.Name.short(try .init("v"))
                #expect(name.short?.character == "v")
                #expect(name.long == nil)
            }

            @Test func `long-only case exposes long, not short`() throws(Argument.Name.Long.Error) {
                let name = Argument.Name.long(try .init("verbose"))
                #expect(name.short == nil)
                #expect(name.long?.string == "verbose")
            }

            @Test func `both case exposes short and long`() {
                let name = Argument.Name.both(
                    // Provably-valid literals ("v", "verbose") — test fixture.
                    // swiftlint:disable:next force_try
                    short: try! .init("v"),
                    // swiftlint:disable:next force_try
                    long: try! .init("verbose")
                )
                #expect(name.short?.character == "v")
                #expect(name.long?.string == "verbose")
            }

            @Test func `Argument.Name.Long.literal constructs validated long name without try`() {
                let name = Argument.Name.Long.literal("verbose")
                #expect(name.string == "verbose")
            }

            @Test func `Argument.Name.Short.literal constructs validated short name without try`() {
                let name = Argument.Name.Short.literal("v")
                #expect(name.character == "v")
            }

            @Test func `Argument.Name.Long.literal accepts hyphenated form`() {
                let name = Argument.Name.Long.literal("dry-run")
                #expect(name.string == "dry-run")
            }

            @Test func `canonical dotted-name forms compose at production sites`() {
                // Production-site shape: declarative, no `try`, no `_unchecked`.
                let names: [Argument.Name] = [
                    .long(.literal("verbose")),
                    .short(.literal("v")),
                    .both(short: .literal("h"), long: .literal("help")),
                ]
                #expect(names.count == 3)
                #expect(names[0].long?.string == "verbose")
                #expect(names[1].short?.character == "v")
                #expect(names[2].short?.character == "h")
                #expect(names[2].long?.string == "help")
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
