# Argument Primitives Scope

`swift-argument-primitives` provides the **CLI argument-parsing vocabulary**: the
`Argument` namespace and the Foundation-free atoms over which command-line
argument schemas are declared and argv streams are interpreted at higher layers.
It owns the option/flag name types (`Argument.Name`, `.Short`, `.Long`), arity,
visibility, help, environment-variable identifiers, argv positions, classified
tokens, the typed-throws error domain, and the schema-as-data combinator surface
(`Argument.Positional`, `.Option`, `.Flag`, `.Group`, `.Subcommand`,
`.Schema.Node`). No parsing *logic* lives at L1 — argv tokenization is an L2
concern (POSIX 12.2) and schema-bound parsing an L3 concern (`swift-arguments`).

## Per-[MOD-017] shape

The package follows `[MOD-017]`: `Argument Primitive` is the layer-invariant,
zero-external-dependency namespace target and owns the `public enum Argument {}`
declaration plus **all stdlib-only foundational vocabulary**. During the L1
core-dissolution sweep (2026-06-23) the implementation-bearing
`Argument Primitives Core` target was dissolved: its 11 stdlib-only declaration
files folded into the `Argument Primitive` root, and its four
external-dependency-bearing declarations were relocated to dedicated
sub-namespace targets per `[MOD-031]` (each declaring the external dependency its
own source imports per `[MOD-002]` amended).

### External-dep sub-namespaces

The Phase-0 audit (`AUDIT-L1-core-dissolution-sweep-2026-06-23.md` §4) classified
Core's content as "16 zero-dep files → root, redistribute 6 funnel deps".
Empirically, four declarations carry external-dependency signatures and therefore
do **not** live in the zero-dep root per `[MOD-017]` content policy; they split
into four sub-namespace targets:

- **Argument Position Primitives** — `Argument.Position` (argv index + byte
  offset), whose signature references `Index<String>` / `Index<Byte>.Offset` →
  declares `Index Primitives` + `Byte Primitives`.
- **Argument Error Primitives** — `Argument.Error` (the typed-throws domain),
  whose `severity` accessor returns `Diagnostic.Severity` and whose cases carry
  `Argument.Position` → declares `Diagnostic Primitives` + `Argument Position
  Primitives`.
- **Argument Environment Primitives** — `Argument.Environment.Variable.Name`
  (`Tagged<Argument.Environment.Variable, String>`) → declares `Tagged
  Primitives`. (The zero-dep `Argument.Environment` / `.Variable` namespace
  enums remain in the root; this sub-namespace only adds the `Tagged`-bearing
  typealias.)
- **Argument Token Primitives** — `Argument.Token` (its `range` is `Text.Range`)
  plus its co-located `Argument.Token.Kind` enum → declares `Text Primitives`.

## Owner targets

- **Argument Primitive** — the `public enum Argument {}` namespace target. Zero
  external deps per `[MOD-017]`. Owns the stdlib-only vocabulary: names, arity,
  visibility, help, and the `Argument.Environment` / `.Variable` namespace enums.
- **Argument {Position,Error,Environment,Token} Primitives** — the four
  external-dep sub-namespaces above, each declaring its own dependency.
- **Argument {Positional,Option,Flag,Group,Subcommand,Schema} Primitives** — the
  schema-as-data combinator surface composed over the vocabulary.
- **Argument Primitives** — umbrella; re-exports the root + all sub-namespaces so
  consumers needing the full surface write `import Argument_Primitives`.
- **Argument Primitives Core** — DEPRECATED time-boxed shim (exports-only).
  Re-exports the pre-migration Core surface (`Argument Primitive` + the four
  sub-namespaces + the `Tagged` / `Text` / `Diagnostic` / `Index` / `Affine` /
  `Byte` funnel) so no consumer (`ieee-1003` L2, `BuildAll`) breaks during the
  sweep. Removed in the cleanup wave.
- **Argument Primitives Test Support** — published test-fixtures product.

## Out of scope

- argv **tokenization** logic — an L2 concern (POSIX 12.2 utility syntax).
- schema-bound **parsing** / command dispatch — an L3 concern (`swift-arguments`).
- environment-variable **reads** and snapshots — L3 (`swift-environment`).

## Evaluation rule

Sub-target additions are evaluated against this scope.

- A proposed addition that is a **stdlib-only argument-vocabulary decl** (a
  namespace, a name/arity/visibility/help atom) lands in the zero-dep
  `Argument Primitive` root.
- A proposed addition whose **signature requires an external dependency** lands in
  its owning sub-namespace target per `[MOD-031]` (existing or new), declaring
  that dependency itself.
