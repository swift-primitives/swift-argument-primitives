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

import Finite_Primitives_Core

@testable import Argument_Primitives_Test_Support

@Suite("Argument.Flag.Enumerable")
struct ArgumentFlagEnumerableTests {

    enum Operation: Argument.Flag.Enumerable {
        case add
        case multiply

        static func flagName(for value: Self) -> Argument.Name.Long {
            switch value {
            case .add: return .literal("add")
            case .multiply: return .literal("multiply")
            }
        }

        static func help(for value: Self) -> Argument.Help {
            switch value {
            case .add: return .init(abstract: "Add operands.")
            case .multiply: return .init(abstract: "Multiply operands.")
            }
        }
    }

    @Test("CaseIterable enumerates every case")
    func caseIterable() {
        let all = Operation.allCases
        #expect(all == [.add, .multiply])
    }

    @Test("flagName(for:) returns the registered long name")
    func flagNameReturnsLong() {
        #expect(Operation.flagName(for: .add).string == "add")
        #expect(Operation.flagName(for: .multiply).string == "multiply")
    }

    @Test("help(for:) carries the per-case abstract")
    func helpCarriesAbstract() {
        #expect(Operation.help(for: .add).abstract == "Add operands.")
        #expect(Operation.help(for: .multiply).abstract == "Multiply operands.")
    }

    @Test("each case maps to a distinct flagName — schema-builder invariant")
    func distinctFlagNames() {
        let names = Operation.allCases.map { Operation.flagName(for: $0).string }
        #expect(Set(names).count == names.count)
    }

    // MARK: - Finite.Enumerable refinement

    @Test("Finite.Enumerable bridge derives count from CaseIterable")
    func bridgedCount() {
        #expect(Operation.count == Cardinal(2))
    }

    @Test("Finite.Enumerable bridge derives ordinal from allCases position")
    func bridgedOrdinal() {
        #expect(Operation.add.ordinal == Ordinal(0))
        #expect(Operation.multiply.ordinal == Ordinal(1))
    }

    @Test("Finite.Enumerable bridge reconstructs value from ordinal")
    func bridgedInitFromOrdinal() {
        #expect(Operation(_unchecked: (), ordinal: Ordinal(0)) == .add)
        #expect(Operation(_unchecked: (), ordinal: Ordinal(1)) == .multiply)
    }

    @Test("init?(_:) round-trips through ordinal for in-bounds values")
    func bridgedTotalInit() {
        #expect(Operation(Ordinal(0)) == .add)
        #expect(Operation(Ordinal(1)) == .multiply)
        #expect(Operation(Ordinal(2)) == nil)
    }

    @Test("Argument.Flag.Enumerable conformer is usable wherever Finite.Enumerable is expected")
    func structuralRefinement() {
        // This generic function accepts ANY Finite.Enumerable — including
        // types unrelated to argument parsing. The fact that Operation
        // type-checks here is the structural-refinement guarantee.
        func sumOfOrdinals<E: Finite.Enumerable>(_: E.Type) -> Cardinal {
            E.allCases.reduce(Cardinal.zero) { partial, value in
                partial + Cardinal(value.ordinal.rawValue)
            }
        }

        // For Operation: 0 + 1 == 1
        #expect(sumOfOrdinals(Operation.self) == Cardinal(1))
    }
}
