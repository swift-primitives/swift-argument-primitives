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

public import Finite_Primitives_Core

extension Argument.Flag {
    /// An enum that maps each case to a long-option name for mutually
    /// exclusive flag dispatch at the L3 schema layer.
    ///
    /// `Argument.Flag.Enumerable` is the L1 vocabulary protocol behind
    /// the institute analog of swift-argument-parser's `EnumerableFlag`.
    /// A conforming enum models a fixed, finite set of dispatch values
    /// where each case is selected at the command line by its own long
    /// option (`--add`, `--multiply`, …) and the cases are mutually
    /// exclusive — the last occurrence wins.
    ///
    /// ## Refinement of `Finite.Enumerable`
    ///
    /// `Argument.Flag.Enumerable` refines ``Finite/Enumerable``. The
    /// underlying `count` / `ordinal` / `init(_unchecked:ordinal:)`
    /// requirements are satisfied automatically by the CaseIterable-default
    /// bridge in `swift-finite-primitives` for any conformer whose
    /// `AllCases` is a `RandomAccessCollection` indexed by `Int` — i.e.,
    /// the common Swift `enum` case with synthesized `[Self]` allCases.
    /// Consumers therefore only need to supply the two CLI-specific
    /// requirements: ``name(for:)`` and ``help(for:)``.
    ///
    /// This refinement makes the protocol structurally equivalent to
    /// `Finite.Enumerable` (a finite, indexable, enumerable type) with
    /// CLI-specific renderings layered on top. The shared spine eliminates
    /// duplicate enumeration concepts in the ecosystem and lets
    /// `Argument.Flag.Enumerable` conformers participate uniformly in any
    /// API that accepts `Finite.Enumerable` (e.g., total-input testing,
    /// ordinal-indexed lookup tables).
    ///
    /// ## Required surface
    ///
    /// - `Finite.Enumerable` (inherited): supplies `CaseIterable + Sendable`
    ///   plus the `count` / `ordinal` / `init(_unchecked:ordinal:)` spine.
    /// - `Hashable`: keeps the dispatch storage trivially index-able.
    /// - ``name(for:)``: the long-option name for each case. Default
    ///   name derivation from the case identifier is unavailable in Swift
    ///   without `Mirror` reflection, so the mapping is an explicit static
    ///   requirement — the conformer owns the case-to-CLI-name mapping at
    ///   compile time.
    /// - ``help(for:)``: per-case documentation rendered in help text.
    ///   Returning an empty ``Argument/Help`` is permitted when no per-case
    ///   description is available.
    ///
    /// ## Example
    ///
    /// ```swift
    /// enum Operation: Argument.Flag.Enumerable {
    ///     case add
    ///     case multiply
    ///
    ///     static func name(for value: Self) -> Argument.Name.Long {
    ///         switch value {
    ///         case .add: return .literal("add")
    ///         case .multiply: return .literal("multiply")
    ///         }
    ///     }
    ///
    ///     static func help(for value: Self) -> Argument.Help {
    ///         switch value {
    ///         case .add: return .init(abstract: "Add operands.")
    ///         case .multiply: return .init(abstract: "Multiply operands.")
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// ## Mutual exclusivity
    ///
    /// The L3 schema layer registers each case as its own long option
    /// binding into the same `WritableKeyPath`. When multiple cases
    /// appear on argv, the rightmost occurrence wins — there is no
    /// `FlagExclusivity` parameter in v1; the last-wins semantics is
    /// fixed.
    public protocol Enumerable: Finite.Enumerable, Hashable {
        /// The long-option name registered for `value`.
        ///
        /// Each enum case maps to a distinct ``Argument/Name/Long``;
        /// duplicated names across cases would create an ambiguous
        /// schema and are rejected at parse-visitor finalization.
        static func name(for value: Self) -> Argument.Name.Long

        /// The help descriptor rendered for `value` in `--help` output.
        ///
        /// Returning ``Argument/Help/init(abstract:discussion:placeholder:defaults:)``
        /// with an empty `abstract` is permitted when no per-case
        /// description is available.
        static func help(for value: Self) -> Argument.Help
    }
}
