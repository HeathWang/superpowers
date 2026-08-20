---
name: brainstorming
description: "You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation."
---

# Brainstorming Ideas Into Designs

Help turn ideas into fully formed designs and specs through natural collaborative dialogue.

Start by classifying how much process the request needs, then work
through your path: understand the context, refine the idea, present a
design, and get your human partner's approval.

<HARD-GATE>
Unless direct-start is active, do NOT invoke any implementation skill, write
code, scaffold a project, or take implementation action until you have told
your human partner what you intend and they have approved it. Every normal path
keeps this approval gate; only explicit direct-start bypasses it.
</HARD-GATE>

## Direct-Start

Direct-start is explicit end-to-end authorization. Activate it only when the
human partner says an equivalent of "start directly", "do not ask", "handle it
yourself", or "continue through completion". Ordinary task verbs such as
"implement", "fix", or "add" do not activate it.

When active:

1. Classify the path internally; do not ask the partner to approve it.
2. Skip ordinary clarification, design-approval, spec-approval,
   plan-execution, and code-review questions.
3. Infer reasonable assumptions and report only material ones at completion.
4. Upgrade the path when hidden complexity appears without leaving
   direct-start.
5. For Architectural work, write and self-review the spec as needed, then route
   plan creation to `writing-plans`; that skill creates the plan and performs
   its one independent plan review.
6. At `write_plan`, pass direct-start to `writing-plans`; that skill owns plan
   creation, the one-pass plan review, executor selection, and continuation.
7. Do not offer or automatically open the Visual Companion.

Direct-start stops only for an irreversible or destructive operation, a
security-sensitive operation, an external side effect that conventionally
requires consent, missing credentials or permissions, or a request so
underspecified that every implementation would be a guess.

## Three Paths

Unless direct-start is active, before your first question classify the
request and say the classification out loud — "this looks bounded, so
I'll present a short design here rather than write a spec" — so your
human partner can override it:

- **Spike** — a feasibility question ("can we...", "is it possible...",
  "quick and dirty is fine") whose output is an answer, not code you
  keep. Present the question and what you'll try in 2-3 sentences, get
  a nod, then find out as cheaply as correctness allows. No design
  doc, no spec file. Report findings as a recommendation; anything you
  built stays labeled throwaway.
- **Bounded** — a well-scoped change to code that already exists in
  this repo: a new flag, a small endpoint, a one-file fix.
  Understanding the kind of app is not enough — bounded means the flow
  you are changing is already here to read. If there is no existing
  flow to change, the task is not bounded. Ask the clarifying
  questions that matter, present a short design IN CHAT (a few
  sentences to a few short paragraphs), and STOP. Implementation
  starts only after your human partner says yes to that design — a
  bounded task's approval is as hard a gate as an architectural
  one. No spec file, no implementation plan document.
- **Architectural** — new projects, new subsystems, changes that
  restructure how components fit together or alter interfaces others
  depend on. Follow the full process: questions, approaches, sectioned
  design, written spec, then the writing-plans skill.

When in doubt between two paths, take the heavier one. The ratchet is
one-way: hidden complexity discovered mid-task upgrades the path —
stop and say so in normal mode, or upgrade internally in direct-start.
Nothing downgrades mid-task.

## Anti-Pattern: "Too Simple To Need Approval"

Every normal path ends with your human partner approving your intent before
implementation. A todo list, a single-function utility, a config change — the
design may be two sentences in chat, but you MUST present it and get approval.
"Simple" tasks are where unexamined assumptions cause the most wasted work.
What scales with simplicity is the artifact, never the approval.

## Red Flags

| Thought | Reality |
|---------|---------|
| "This is too simple to need a design" | Simple means a short design, not no design. Two sentences in chat, then approval. |
| "I'll call it bounded and skip the spec" | Reaching for a label to skip work IS the doubt — take the heavier path. |
| "It's bounded and the design is obvious — I'll start while they read it" | The gate is the approval, not the design's length. Present, then stop until you hear yes. |
| "I understand this kind of app, so it's bounded" | Bounded measures the repo, not your familiarity. A new project has no existing flow — it is architectural. |
| "The spike works, so I'll keep the code" | A spike's output is an answer. Keeping the code is a new request — classify it. |
| "It grew, but I'm almost done — no need to re-classify" | Hidden complexity upgrades the path mid-task. Stop and say so in normal mode; upgrade internally in direct-start. |
| "They approved the spike, so the follow-up change is approved too" | Each normal task gets its own classification and its own approval. |
| "They said implement, so direct-start is implied" | Task verbs describe the work; only explicit end-to-end authorization activates direct-start. |

## Checklist

Classify first, announce the path in normal mode, then create a task for each
item on your path. Complete ordinary items in order. A condition-triggered
item is a standing gate evaluated while later items proceed; trigger it only
when its stated predicate becomes true, and skip it if the predicate never
becomes true.

**Spike:**
1. **Explore project context** — enough to frame the probe
2. **Present question + probe plan** — 2-3 sentences
3. **Get approval** — a nod is enough
4. **Investigate** — as cheaply as correctness allows
5. **Report findings** — a recommendation; label anything built as throwaway

**Bounded:**
1. **Explore project context** — check files, docs, recent commits
2. **Ask clarifying questions** — one at a time, the ones that matter
3. **Present short design in chat** — approach, files touched, testing
4. **Get approval** — STOP and wait for an explicit yes; presenting the design and starting in the same breath is skipping the gate
5. **Implement** — proceed with the normal development workflow. Select TDD
   only when the human partner explicitly requested it or the approved
   requirements require it; otherwise use Standard testing. No plan document.

**Architectural:**
1. **Explore project context** — check files, docs, recent commits
2. **Offer the visual companion just-in-time** — NOT upfront. The first time a question would genuinely be clearer shown than described, offer it then (its own message); on approval its browser tab opens for you. If no visual question ever arises, never offer it. See the Visual Companion section below.
3. **Ask clarifying questions** — one at a time, understand purpose/constraints/success criteria
4. **Propose 2-3 approaches** — with trade-offs and your recommendation
5. **Present design** — in sections scaled to their complexity, get user approval after each section
6. **Write design doc** — save to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`; leave it unstaged and uncommitted
7. **Spec self-review** — quick inline check for placeholders, contradictions, ambiguity, scope (see below)
8. **User reviews written spec** — ask user to review the spec file before proceeding
9. **Transition to implementation** — invoke writing-plans skill to create implementation plan

**Direct-start:**
1. **Explore project context** — enough to classify and identify blockers
2. **Classify internally** — Spike, Bounded, or Architectural; never downgrade
3. **Infer decisions** — record only material assumptions for the final report
4. **Route internally** — report findings, implement without a plan, or enter
   `write_plan`, which passes the state to `writing-plans`
5. **Hand off at the terminal route** — pass the state only. `writing-plans`
   owns plan creation, review, and executor selection for `write_plan`; the
   downstream development workflow owns implementation, review, verification,
   and completion. Brainstorming does not continue beyond its terminal route.

## Process Flow

```dot
digraph brainstorming {
    "Explicit direct-start?" [shape=diamond];
    "Classify aloud" [shape=box];
    "Classify internally" [shape=box];
    "Spike" [shape=diamond];
    "Bounded" [shape=diamond];
    "Architectural" [shape=diamond];
    "Normal path approvals" [shape=box];
    "Infer decisions; no ordinary questions" [shape=box];
    "report_findings" [shape=doublecircle];
    "implement_without_plan" [shape=doublecircle];
    "write_plan" [shape=doublecircle];

    "Explicit direct-start?" -> "Classify internally" [label="yes"];
    "Explicit direct-start?" -> "Classify aloud" [label="no"];
    "Classify aloud" -> "Spike";
    "Classify aloud" -> "Bounded";
    "Classify aloud" -> "Architectural";
    "Classify internally" -> "Infer decisions; no ordinary questions";
    "Infer decisions; no ordinary questions" -> "report_findings" [label="Spike"];
    "Infer decisions; no ordinary questions" -> "implement_without_plan" [label="Bounded"];
    "Infer decisions; no ordinary questions" -> "write_plan" [label="Architectural"];
    "Spike" -> "Normal path approvals";
    "Bounded" -> "Normal path approvals";
    "Architectural" -> "Normal path approvals";
    "Normal path approvals" -> "report_findings" [label="Spike"];
    "Normal path approvals" -> "implement_without_plan" [label="Bounded"];
    "Normal path approvals" -> "write_plan" [label="Architectural"];
}
```

## Terminal Routing

Brainstorming has exactly three terminal states:

1. `report_findings` — Spike reports its recommendation.
2. `implement_without_plan` — approved normal Bounded work, or direct-start
   Bounded work, enters the normal development workflow without a plan.
3. `write_plan` — Architectural work invokes `superpowers:writing-plans`.

In normal mode, `writing-plans` handles `write_plan` by ending at the reviewed
plan's three execution choices: Subagent-Driven, Inline Execution, or Do
Nothing. Implementation starts only after the human partner selects one.

`write_plan` is a Brainstorming terminal state. It invokes
`superpowers:writing-plans` with the normal/direct-start state and does not
choose an executor. `writing-plans` owns the review and mode-specific handoff.

## The Process

The subsections below serve the normal Bounded and Architectural paths. A
normal Spike stops at "present the probe, get a nod." Direct-start uses the
same design principles internally while skipping ordinary questions and
approval gates.

**Understanding the idea:**

- Check out the current project state first (files, docs, recent commits)
- Before asking detailed questions, assess scope: if the request describes multiple independent subsystems (e.g., "build a platform with chat, file storage, billing, and analytics"), flag this immediately. Don't spend questions refining details of a project that needs to be decomposed first.
- If the project is too large for a single spec, help the user decompose into sub-projects: what are the independent pieces, how do they relate, what order should they be built? Then brainstorm the first sub-project through the normal design flow. Each sub-project gets its own spec → plan → implementation cycle.
- For appropriately-scoped projects in normal mode, ask questions one at a time to refine the idea
- In direct-start, infer the likely intent from repository context instead of running the normal questioning loop
- Prefer multiple choice questions when possible, but open-ended is fine too
- Only one question per message — if a topic needs more exploration, break it into multiple questions
- Focus on understanding: purpose, constraints, success criteria

**Exploring approaches:**

- In normal mode, propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why
- YAGNI ruthlessly — remove unnecessary features from every approach and design

**Presenting the design:**

- In normal mode, once you believe you understand what you're building, present the design
- Scale each section to its complexity: a few sentences if straightforward, up to 200-300 words if nuanced
- Ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

**Design for isolation and clarity:**

- Break the system into smaller units that each have one clear purpose, communicate through well-defined interfaces, and can be understood and tested independently
- For each unit, you should be able to answer: what does it do, how do you use it, and what does it depend on?
- Can someone understand what a unit does without reading its internals? Can you change the internals without breaking consumers? If not, the boundaries need work.
- Smaller, well-bounded units are also easier for you to work with — you reason better about code you can hold in context at once, and your edits are more reliable when files are focused. When a file grows large, that's often a signal that it's doing too much.

**Working in existing codebases:**

- Explore the current structure before proposing changes. Follow existing patterns.
- Where existing code has problems that affect the work (e.g., a file that's grown too large, unclear boundaries, tangled responsibilities), include targeted improvements as part of the design — the way a good developer improves code they're working in.
- Don't propose unrelated refactoring. Stay focused on what serves the current goal.

## After the Design (normal Architectural path)

**Documentation:**

- Write the validated design (spec) to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
  - (Human partner preferences for spec location override this default)
- Use elements-of-style:writing-clearly-and-concisely skill if available
- Leave the design document unstaged and uncommitted

**Spec Self-Review:**
After writing the spec document, look at it with fresh eyes:

1. **Placeholder scan:** Any "TBD", "TODO", incomplete sections, or vague requirements? Fix them.
2. **Internal consistency:** Do any sections contradict each other? Does the architecture match the feature descriptions?
3. **Scope check:** Is this focused enough for a single implementation plan, or does it need decomposition?
4. **Ambiguity check:** Could any requirement be interpreted two different ways? If so, pick one and make it explicit.

Fix any issues inline. No need to re-review — just fix and move on.

**User Review Gate:**
After the spec review loop passes, ask the human partner to review the written
spec before proceeding:

> "Spec written to `<path>`. Please review it and let me know if you want to make any changes before we start writing out the implementation plan."

Wait for the human partner's response. If they request changes, make them and
re-run the spec review loop. Only proceed once they approve.

**Implementation:**

- Invoke the writing-plans skill to create a detailed implementation plan
- Do NOT invoke any other skill. writing-plans is the next step.

## Visual Companion

This section applies only to normal Architectural mode. Direct-start neither
offers nor automatically opens the Visual Companion.

A browser-based companion for showing mockups, diagrams, and visual options during brainstorming. Available as a tool — not a mode. Accepting the companion means it's available for questions that benefit from visual treatment; it does NOT mean every question goes through the browser.

**Offering the companion (just-in-time):** Do NOT offer it upfront. Wait until a question would genuinely be clearer shown than told — a real mockup / layout / diagram question, not merely a UI *topic*. The first time that happens, offer it then, as its own message:
> "This next part might be easier if I show you — I can put together mockups, diagrams, and comparisons in a browser tab as we go. It's still new and can be token-intensive. Want me to? I'll open it for you."

**This offer MUST be its own message.** Only the offer — no clarifying question, summary, or other content. Wait for the user's response. If they accept, start the server with `--open` so their browser opens to the first screen automatically. If they decline, continue text-only and don't offer again unless they raise it.

**Per-question decision:** Even after the user accepts, decide FOR EACH QUESTION whether to use the browser or the terminal. The test: **would the user understand this better by seeing it than reading it?**

- **Use the browser** for content that IS visual — mockups, wireframes, layout comparisons, architecture diagrams, side-by-side visual designs
- **Use the terminal** for content that is text — requirements questions, conceptual choices, tradeoff lists, A/B/C/D text options, scope decisions

A question about a UI topic is not automatically a visual question. "What does personality mean in this context?" is a conceptual question — use the terminal. "Which wizard layout works better?" is a visual question — use the browser.

If they agree to the companion, read the detailed guide before proceeding:
`skills/brainstorming/visual-companion.md`
