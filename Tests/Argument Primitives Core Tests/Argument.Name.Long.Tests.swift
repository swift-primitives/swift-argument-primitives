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

extension Argument.Name.Long {
    @Suite("Argument.Name.Long")
    struct Test {
        @Suite struct Unit {
            @Test func `accepts simple letter sequence`() throws(Argument.Name.Long.Error) {
                let name = try Argument.Name.Long("verbose")
                #expect(name.string == "verbose")
            }

            @Test func `accepts hyphenated form`() throws(Argument.Name.Long.Error) {
                let name = try Argument.Name.Long("dry-run")
                #expect(name.string == "dry-run")
            }

            @Test func `accepts letter followed by digits`() throws(Argument.Name.Long.Error) {
                let name = try Argument.Name.Long("v2")
                #expect(name.string == "v2")
            }

            @Test func `literal factory constructs validated name without try`() {
                let name = Argument.Name.Long.literal("verbose")
                #expect(name.string == "verbose")
            }

            @Test func `literal factory accepts hyphenated form`() {
                let name = Argument.Name.Long.literal("dry-run")
                #expect(name.string == "dry-run")
            }

            @Test func `literal factory accepts letter-followed-by-digits`() {
                let name = Argument.Name.Long.literal("v2")
                #expect(name.string == "v2")
            }
        }

        @Suite struct `Edge Case` {
            @Test func `rejects empty string`() {
                #expect(throws: Argument.Name.Long.Error.empty) {
                    _ = try Argument.Name.Long("")
                }
            }

            @Test func `rejects leading digit`() {
                #expect(throws: Argument.Name.Long.Error.doesNotStartWithLetter(found: "9")) {
                    _ = try Argument.Name.Long("9lives")
                }
            }

            @Test func `rejects underscore`() {
                #expect(throws: Argument.Name.Long.Error.invalidCharacter(found: "_")) {
                    _ = try Argument.Name.Long("dry_run")
                }
            }

            @Test func `rejects non-ASCII character`() {
                #expect(throws: Argument.Name.Long.Error.invalidCharacter(found: "ø")) {
                    _ = try Argument.Name.Long("nøde")
                }
            }
        }

        @Suite struct Integration {}
    }
}
