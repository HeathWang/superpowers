# Brainstorming Execution Routing Design

**Date:** 2026-08-20

## Goal

Adopt the upstream v6.3.0 `Spike / Bounded / Architectural` brainstorming
model as the primary workflow while preserving a small, explicit compatibility
layer for autonomous execution, plan review, and execution selection.

## Design Principles

1. Upstream brainstorming remains the source of truth for normal interaction.
2. Direct-start is an explicit user authorization, not an agent inference.
3. Brainstorming decides whether a plan is needed; it does not review plans or
   choose an executor.
4. Plan review and execution handoff belong to `writing-plans`.
5. There is no separate `continuous-execution` state.
6. The upstream v6.3.0 Visual Companion workflow is adopted as one complete
   feature rather than merged with the fork's existing wording.

## Request Modes

### Normal Mode

Normal mode uses the upstream paths without weakening their approval gates.

- **Spike:** present the probe, get approval, investigate, and report findings.
- **Bounded:** ask necessary questions, present a short in-chat design, get
  approval, and implement without a plan.
- **Architectural:** explore context, offer the Visual Companion just in time
  when the first genuinely visual question appears, ask questions, compare
  approaches, present and approve the design, write and approve a spec, then
  create a plan.

The path may only upgrade when hidden complexity appears. It may not downgrade
mid-task.

Brainstorming has exactly three normal-mode terminal states:

1. `report_findings`
2. `implement_without_plan`
3. `write_plan`

This keeps the module interface small: brainstorming classifies the request,
obtains the approvals required by the selected path, and decides whether
durable planning is required.

### Direct-Start Mode

Direct-start activates only when the user explicitly says an equivalent of
"start directly", "do not ask", "handle it yourself", or "continue through
completion". Ordinary task verbs such as "implement", "fix", or "add" do not
activate it.

Once active, direct-start grants end-to-end autonomous execution:

1. The agent classifies the task internally.
2. The agent does not ask clarifying, design-approval, spec-approval,
   plan-execution, or code-review questions.
3. The agent infers reasonable assumptions and records only material ones in
   its final report.
4. The agent decides whether a design, spec, or plan is needed.
5. If a plan is created, it receives the same plan-review gate as normal mode.
6. After plan review, the agent selects an executor and continues without
   presenting execution choices.
7. Hidden complexity upgrades the internal workflow without leaving
   direct-start mode.
8. The agent decides whether code review is warranted from the change risk.
9. The agent does not offer or automatically open the Visual Companion.

Direct-start may stop only for:

- irreversible or destructive operations;
- security-sensitive operations;
- external side effects that conventionally require consent;
- missing credentials or permissions;
- a task so underspecified that every implementation path would be a guess.

These are safety and feasibility stops, not ordinary brainstorming questions.

## Visual Companion

Normal mode adopts the upstream v6.3.0 Visual Companion workflow in full:

1. The offer is available on the Architectural path.
2. Do not offer it upfront. Wait until the first question that would genuinely
   be clearer when shown rather than described.
3. The offer is its own message with no additional question, summary, or
   content.
4. If accepted, start the server with `--open`.
5. If declined, continue text-only and do not offer again unless the user
   raises it.
6. After acceptance, decide per question whether visual or text presentation
   is more appropriate.
7. Use the browser for mockups, wireframes, layout comparisons, architecture
   diagrams, and other inherently visual choices.
8. Use text for conceptual choices, requirements, scope, and trade-off lists.

Direct-start skips the offer because its explicit contract prohibits ordinary
questions. It also does not open the Visual Companion automatically.

The upstream implementation is authoritative for this feature. The fork must
take the upstream versions of:

- the Visual Companion sections and checklist step in
  `skills/brainstorming/SKILL.md`;
- `skills/brainstorming/visual-companion.md`;
- `skills/brainstorming/scripts/`;
- `tests/brainstorm-server/`.

Do not retain fork-specific wording or behavior inside this feature. Files that
are already byte-equivalent to upstream still remain in the overwrite scope so
future integration does not accidentally preserve a fork-only variant.

## Plan Review

`writing-plans` owns plan review after writing and self-reviewing the complete
plan.

1. Dispatch exactly one read-only plan reviewer using
   `plan-document-reviewer-prompt.md`.
2. The reviewer checks completeness, requirement or spec alignment, task
   decomposition, interface consistency, and buildability.
3. The reviewer reports only implementation-blocking issues as findings.
4. If findings exist, the current agent fixes them and repeats its own
   self-review.
5. Do not dispatch another reviewer by default. The single independent pass
   avoids an unbounded review loop.

The reviewer prompt must support plans without a spec. When no spec exists, the
approved requirements and plan constraints are the review authority.

## Execution Handoff

After plan review:

### Normal Mode

Show these choices and stop:

1. **Subagent-Driven** — recommended; execute task-by-task with independent
   implementation and review.
2. **Inline Execution** — execute in the current session using
   `executing-plans`.
3. **Do Nothing** — leave the reviewed plan saved without implementation.

Implementation starts only after the user selects an option.

### Direct-Start Mode

Do not show choices. Select the safest suitable executor:

- prefer Subagent-Driven for plans with independent tasks and available
  subagents;
- use Inline Execution for tightly coupled tasks or when subagents are
  unavailable.

Continue through implementation, verification, risk-appropriate review, and
completion reporting.

## Removed Fork Behavior

The compatibility layer intentionally removes:

- the separate `continuous-execution` authorization state;
- the rule limiting direct-start to small tasks;
- the completion-time question asking whether to escalate to code review;
- duplicate post-design routing in
  `skills/brainstorming/after-the-design.md`;
- the fork's default single-path brainstorming flow.

Upstream's Red Flags and three-path rules replace the duplicate
anti-rationalization material. Upstream's Visual Companion flow replaces the
fork's current offer and launch guidance.

## Expected File Changes

- Replace `skills/brainstorming/SKILL.md` with the upstream v6.3.0 structure,
  including its complete Visual Companion flow, then add the compact
  direct-start mode and its autonomous terminal routing.
- Replace `skills/brainstorming/visual-companion.md`,
  `skills/brainstorming/scripts/`, and `tests/brainstorm-server/` with the
  upstream v6.3.0 versions as a single feature unit.
- Remove the obsolete fork-only
  `skills/brainstorming/after-the-design.md` and
  `skills/brainstorming/anti-rationalizations.md` references and files.
- Update `skills/writing-plans/SKILL.md` to invoke one plan reviewer before its
  execution handoff, while preserving the fork's existing testing modes,
  uncommitted-change policy, and three execution choices.
- Update
  `skills/writing-plans/plan-document-reviewer-prompt.md` so the spec input is
  optional and the reviewer remains read-only and findings-focused.
- Add or update behavior tests covering request routing and handoff wording.

## Required Behavior Tests

1. A normal bounded request asks only necessary questions, presents a short
   design, and waits for approval before implementation.
2. A normal architectural request produces an approved spec and reviewed plan,
   then stops at the three execution choices.
3. "Implement X" alone does not activate direct-start.
4. "Start directly and do not ask" activates autonomous execution for both
   bounded and architectural work.
5. Direct-start may internally create and review a plan but never displays the
   execution-choice question.
6. Normal mode never starts a reviewed plan before the user selects an
   executor.
7. A plan reviewer receives either a spec path or explicit no-spec authority.
8. Reviewer findings are fixed and self-reviewed without an automatic second
   reviewer dispatch.
9. Hidden complexity upgrades the path without disabling direct-start.
10. Safety, permission, and irreversible-operation blockers still stop
    direct-start.
11. A normal Architectural request offers Visual Companion only when a
    genuinely visual question first appears, using a message containing only
    the upstream offer.
12. A normal request that never reaches a visual question never receives the
    offer.
13. Direct-start neither offers nor automatically opens Visual Companion.
14. The Visual Companion guide, scripts, and brainstorm-server tests match the
    upstream v6.3.0 source.

## Non-Goals

- Redesigning Subagent-Driven Development.
- Changing the fork's snapshot or commit policy.
- Changing the implementation details of Inline Execution.
- Automatically selecting TDD.
- Preserving fork behavior that duplicates or contradicts the upstream
  three-path router.
