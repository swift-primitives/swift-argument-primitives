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

extension Argument.Name.Short {
    @Suite("Argument.Name.Short")
    struct Test {
        @Suite struct Unit {
            @Test func `accepts ASCII letter`() throws(Argument.Name.Short.Error) {
                let name = try Argument.Name.Short("f")
                #expect(name.character == "f")
            }

            @Test func `accepts ASCII digit`() throws(Argument.Name.Short.Error) {
                let name = try Argument.Name.Short("3")
                #expect(name.character == "3")
            }

            @Test func `accepts ASCII uppercase letter`() throws(Argument.Name.Short.Error) {
                let name = try Argument.Name.Short("F")
                #expect(name.character == "F")
            }

            @Test func `unchecked initializer bypasses validation`() {
                let name = Argument.Name.Short(_unchecked: "ø")
                #expect(name.character == "ø")
            }

            @Test func `literal factory constructs validated character without try`() {
                let name = Argument.Name.Short.literal("v")
                #expect(name.character == "v")
            }

            @Test func `literal factory accepts ASCII digit`() {
                let name = Argument.Name.Short.literal("3")
                #expect(name.character == "3")
            }

            @Test func `literal factory accepts uppercase letter`() {
                let name = Argument.Name.Short.literal("F")
                #expect(name.character == "F")
            }
        }

        @Suite struct `Edge Case` {
            @Test func `rejects non-ASCII letter`() {
                #expect(throws: Argument.Name.Short.Error.notASCIIAlphanumeric(found: "ø")) {
                    _ = try Argument.Name.Short("ø")
                }
            }

            @Test func `rejects punctuation`() {
                #expect(throws: Argument.Name.Short.Error.notASCIIAlphanumeric(found: "-")) {
                    _ = try Argument.Name.Short("-")
                }
            }
        }

        @Suite struct Integration {}
    }
}
