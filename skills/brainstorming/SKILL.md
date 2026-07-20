---
name: brainstorming
description: You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements before implementation.
---

# Brainstorming Ideas Into Designs

Help turn ideas into designs and, when needed, specs through natural collaborative dialogue.

Default path: explore the current project context, ask questions one at a time, then present a design and get approval. Direct-start is an explicit opt-out, not the default.

<HARD-GATE>
Unless the user explicitly authorizes direct-start, do NOT invoke any implementation skill, write any code, scaffold any project, or take any implementation action until you have presented a design and the user has approved it. This applies to EVERY project regardless of perceived simplicity.
</HARD-GATE>

<COMPLETION-GATE>
On the small direct implementation path, the final response is blocked until requesting-code-review escalation consent has been handled.

Before any final response that claims implementation is complete:
1. Finish the final self-review and verification pass.
2. If the user already explicitly requested code review at this point, invoke `superpowers:requesting-code-review` as the sole review-routing skill.
3. If the user already explicitly declined or prohibited code review, complete normally.
4. Otherwise ask whether they want the `superpowers:requesting-code-review` escalation workflow and stop.

Phrase this offer as escalation to the requesting-code-review workflow, not as an offer to personally review the files. When the user replies to this gate with "code review", "代码审查", "yes, review", or an equivalent consent phrase, treat it as acceptance of the escalation offer. Invoke `superpowers:requesting-code-review` only; do NOT also invoke generic file/diff/code-review skills. The requesting-code-review skill owns any reviewer dispatch or review workflow.

This exclusion is scoped to completion-gate replies. A fresh, unrelated request like "review this diff" with files or a patch is a normal review request, not automatic escalation consent.

A completion summary that omits this question is a process failure. Small scope, direct-start mode, successful verification, or "just a quick final update" do not skip this gate.
</COMPLETION-GATE>

## Direct-Start Override

Direct-start mode requires an explicit user override that you can quote from the user's message. Match the user's actual language; semantic equivalents in any language count.

- Task verbs such as "implement", "fix", "update", or "add" describe **what** to do; they do **not** waive questioning or design approval
- Valid overrides sound like "start directly", "don't ask follow-up questions", "skip the design", "just do it", or "continue through completion", or clear equivalents in the user's language
- If you cannot point to the user's explicit override, stay on the default path
- In direct-start mode, infer reasonable constraints from context, state only material assumptions, and ask at most the minimum blocking question
- Do not treat size, confidence, or file references as implied permission to skip brainstorming

## Plan Handoff Authorization

`direct-start` and `continuous-execution` are independent authorization states.
Record each only when the user's explicit words support it:

| User wording | `direct-start` | `continuous-execution` |
|---|---:|---:|
| "Implement X", "fix Y", or another task verb | no | no |
| "Start directly", "skip the design", or "just do it" | yes | no |
| "Continue through completion", "do not pause unless blocked", or a clear equivalent | yes | yes |

<PLAN-HANDOFF-GATE>
For larger work routed to `superpowers:writing-plans`, plan creation and plan
execution are separate transitions.

After the plan is saved and self-reviewed:

- If `continuous-execution` is active, continue without an execution-choice
  question. Use the user's specified execution workflow; if none was specified,
  invoke `superpowers:subagent-driven-development` as the recommended default.
- Otherwise, the handoff response consists of the saved plan path, the
  execution choices required by `superpowers:writing-plans`, and one question
  asking the user to choose. End the turn there.

On the second path, implementation starts only after the user selects an
execution approach or explicitly asks to execute the plan. Design approval,
spec approval, a direct-start-only override, task verbs, urgency, fresh
context, and a "recommended" label do not satisfy this execution predicate.
</PLAN-HANDOFF-GATE>

## Anti-Pattern: "This Is Too Simple To Need A Design"

By default, every project goes through this process. A todo list, a single-function utility, a config change — all of them. "Simple" projects are where unexamined assumptions cause the most wasted work. The design can be short (a few sentences for truly simple projects), but you MUST still present it and get approval.

For pressure cases, rationalizations, and self-checks, see [anti-rationalizations.md](anti-rationalizations.md).

## Checklist

You MUST create a task for each checklist item and complete them in order. Skip dialogue-only items when direct-start is active, skip design-doc-only items when no written spec is needed, and apply each item's own skip conditions where stated.

1. **Explore project context** — check the relevant files, docs, and existing patterns
2. **Check explicit authorization states** — record `direct-start` and `continuous-execution` independently from words you can quote; offer visual companion in its own message only when visual questions are likely
3. **Ask clarifying questions** — in the default path, ask one at a time until purpose, constraints, and success criteria are clear
4. **Propose approaches** — in the default path, present 2-3 options with trade-offs and a recommendation
5. **Present design** — in the default path, present the design in sections and get approval
6. **Judge complexity** — decide whether the work is small enough to skip both durable planning and a written spec, or complex enough to need a written design doc and/or `superpowers:writing-plans`
7. **Write design doc when needed** — save the validated design only when it adds durable value, then self-review it for placeholders, contradictions, scope drift, and ambiguity
8. **User reviews written spec** — if you wrote a design doc, stop and wait for the user's approval before planning or follow-up work
9. **Route into follow-up work** — if the work is small, local, and non-complex, continue directly from the approved design on the default path, or directly after direct-start context analysis on the direct-start path, and later follow the closing discipline from `superpowers:executing-plans`; otherwise use `superpowers:writing-plans`, then apply the plan handoff gate before any implementation
10. **Offer code-review escalation** — after final self-review and verification on the small direct path, ask whether the user wants the `superpowers:requesting-code-review` escalation workflow unless they already accepted, declined, or prohibited it. If yes, invoke only `superpowers:requesting-code-review` before dispatching any review subagent; do not also invoke generic review skills or recreate its workflow from memory

## Process Flow

```dot
digraph brainstorming {
    "Explore project context" [shape=box];
    "User explicitly says\nstart directly?" [shape=diamond];
    "Analyze context and\ninfer assumptions" [shape=box];
    "Visual questions ahead?" [shape=diamond];
    "Offer Visual Companion\n(own message, no other content)" [shape=box];
    "Ask clarifying questions" [shape=box];
    "Propose 2-3 approaches" [shape=box];
    "Present design sections" [shape=box];
    "User approves design?" [shape=diamond];
    "Small, local,\nnon-complex change?" [shape=diamond];
    "Need design doc?" [shape=diamond];
    "Write design doc" [shape=box];
    "User reviews spec?" [shape=diamond];
    "Start implementation directly" [shape=box];
    "Read changed files,\nself-review, and verify" [shape=box];
    "User wants\ncode review?" [shape=diamond];
    "Invoke superpowers:requesting-code-review skill" [shape=box];
    "Invoke writing-plans skill" [shape=box];
    "Continuous execution\nexplicitly authorized?" [shape=diamond];
    "Present execution choices\nand STOP" [shape=doublecircle];
    "Use requested executor\nor recommended SDD" [shape=doublecircle];
    "Complete follow-up work" [shape=doublecircle];

    "Explore project context" -> "User explicitly says\nstart directly?";
    "User explicitly says\nstart directly?" -> "Analyze context and\ninfer assumptions" [label="yes"];
    "User explicitly says\nstart directly?" -> "Visual questions ahead?" [label="no"];
    "Analyze context and\ninfer assumptions" -> "Small, local,\nnon-complex change?";
    "Visual questions ahead?" -> "Offer Visual Companion\n(own message, no other content)" [label="yes"];
    "Visual questions ahead?" -> "Ask clarifying questions" [label="no"];
    "Offer Visual Companion\n(own message, no other content)" -> "Ask clarifying questions";
    "Ask clarifying questions" -> "Propose 2-3 approaches";
    "Propose 2-3 approaches" -> "Present design sections";
    "Present design sections" -> "User approves design?";
    "User approves design?" -> "Present design sections" [label="no, revise"];
    "User approves design?" -> "Small, local,\nnon-complex change?" [label="yes"];
    "Small, local,\nnon-complex change?" -> "Start implementation directly" [label="yes"];
    "Small, local,\nnon-complex change?" -> "Need design doc?" [label="no"];
    "Need design doc?" -> "Write design doc" [label="yes"];
    "Need design doc?" -> "Invoke writing-plans skill" [label="no"];
    "User reviews spec?" -> "Write design doc" [label="changes requested"];
    "Write design doc" -> "User reviews spec?";
    "User reviews spec?" -> "Invoke writing-plans skill" [label="approved"];
    "Invoke writing-plans skill" -> "Continuous execution\nexplicitly authorized?";
    "Continuous execution\nexplicitly authorized?" -> "Present execution choices\nand STOP" [label="no"];
    "Continuous execution\nexplicitly authorized?" -> "Use requested executor\nor recommended SDD" [label="yes"];
    "Start implementation directly" -> "Read changed files,\nself-review, and verify";
    "Read changed files,\nself-review, and verify" -> "User wants\ncode review?";
    "User wants\ncode review?" -> "Invoke superpowers:requesting-code-review skill" [label="yes"];
    "User wants\ncode review?" -> "Complete follow-up work" [label="no"];
    "Invoke superpowers:requesting-code-review skill" -> "Complete follow-up work";
}
```

**Routing depends on complexity, not preference alone.** In direct-start mode, make that judgment from context yourself. Otherwise, make it after design approval. If you are genuinely unsure whether the work is still "small", bias toward `superpowers:writing-plans`. On the small direct path, borrow the final self-review and verification discipline from `superpowers:executing-plans`; do not invoke that skill unless a written implementation plan actually exists. On the plan path, use the plan handoff gate: direct-start alone does not authorize execution after plan creation.

## The Process

**Understanding the idea:**

- Check out the current project state first (files, docs, recent commits)
- Before asking detailed questions, assess scope: if the request describes multiple independent subsystems (e.g., "build a platform with chat, file storage, billing, and analytics"), flag this immediately. Don't spend questions refining details of a project that needs to be decomposed first.
- If the request spans multiple subsystems or a cross-cutting feature bundle, decompose it into sub-projects before implementation planning, even in direct-start mode: what are the independent pieces, how do they relate, what order should they be built? Then brainstorm the first sub-project through the normal design flow. Each sub-project gets its own design → optional spec → plan → implementation cycle.
- In direct-start mode, infer the likely intent from context instead of running the normal questioning loop
- For appropriately-scoped projects on the default path, ask questions one at a time to refine the idea
- Prefer multiple choice questions when possible, but open-ended is fine too
- Only one question per message - if a topic needs more exploration, break it into multiple questions
- Focus on understanding: purpose, constraints, success criteria

**Exploring approaches:**

- In the default path, propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

**Presenting the design:**

- In the default path, once you believe you understand what you're building, present the design
- Scale each section to its complexity: a few sentences if straightforward, up to 200-300 words if nuanced
- In the default path, ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Treat TDD as selected only when the human partner explicitly requests it or an approved spec requires it; discussing testing does not select TDD
- Be ready to go back and clarify if something doesn't make sense

**Complexity routing:**

- After design approval in the default path, or immediately after context analysis in direct-start mode, make an explicit complexity judgment
- Small, local, low-risk work skips both the written design doc and `superpowers:writing-plans`
- Cross-cutting, high-risk, multi-step, or rollback-sensitive work should use `superpowers:writing-plans`
- For larger or uncertain work, `superpowers:writing-plans` is the default next step; a design doc is optional and never a prerequisite for that transition
- If a larger design was approved in chat, you may move straight into `superpowers:writing-plans`; do not create a spec afterward unless it adds durable value
- After `superpowers:writing-plans` completes, either continue under an explicit `continuous-execution` authorization or present its execution choices and stop
- Write a design doc only when it adds durable value; do not create one just because brainstorming happened

**Design for isolation and clarity:**

- Break the system into smaller units that each have one clear purpose, communicate through well-defined interfaces, and can be understood and tested independently
- For each unit, you should be able to answer: what does it do, how do you use it, and what does it depend on?
- Can someone understand what a unit does without reading its internals? Can you change the internals without breaking consumers? If not, the boundaries need work.
- Smaller, well-bounded units are also easier for you to work with - you reason better about code you can hold in context at once, and your edits are more reliable when files are focused. When a file grows large, that's often a signal that it's doing too much.

**Working in existing codebases:**

- Explore the current structure before proposing changes. Follow existing patterns.
- Where existing code has problems that affect the work (e.g., a file that's grown too large, unclear boundaries, tangled responsibilities), include targeted improvements as part of the design - the way a good developer improves code they're working in.
- Don't propose unrelated refactoring. Stay focused on what serves the current goal.

## After the Design

For design-doc writing, spec self-review, user review gating, and post-approval implementation routing, see [after-the-design.md](after-the-design.md).

## Key Principles

- **One question at a time** - Don't overwhelm with multiple questions when questions are actually needed
- **Multiple choice preferred** - Easier to answer than open-ended when possible
- **YAGNI ruthlessly** - Remove unnecessary features from all designs
- **Explore alternatives** - In the default path, propose 2-3 approaches before settling
- **Incremental validation** - In the default path, present design and get approval before implementation
- **Be flexible** - Go back and clarify when something doesn't make sense
