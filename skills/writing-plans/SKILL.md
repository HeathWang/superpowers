---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write comprehensive implementation plans assuming the engineer has zero context for our codebase and questionable taste. Document everything they need to know: which files to touch for each task, code, testing, docs they might need to check, how to test it. Give them the whole plan as bite-sized tasks. DRY. YAGNI. Use the testing workflow the human partner or approved spec actually requires. Include frequent verification checkpoints.

Assume they are a skilled developer, but know almost nothing about our toolset or problem domain. Assume they don't know good test design very well.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Context:** If working in an isolated worktree, it should have been created via the `superpowers:using-git-worktrees` skill at execution time.

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`
- (User preferences for plan location override this default)

## Scope Check

If the spec covers multiple independent subsystems, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

## Testing Mode

Choose one mode before writing tasks:

- **TDD** — only when the human partner explicitly requested TDD or the approved spec requires it. Invoke `superpowers:test-driven-development` and use RED-GREEN-REFACTOR.
- **Standard** — the default. Add appropriate automated tests and validation, but do not impose test-first ordering, RED/GREEN evidence, or the TDD skill.

Needing tests, changing behavior, fixing a bug, or adding a feature does not by
itself select TDD. Record the selected mode in the plan header and in every
task so an executor that receives only one task cannot infer a different mode.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for. This is where decomposition decisions get locked in.

- Design units with clear boundaries and well-defined interfaces. Each file should have one clear responsibility.
- You reason best about code you can hold in context at once, and your edits are more reliable when files are focused. Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns. If the codebase uses large files, don't unilaterally restructure - but if a file you're modifying has grown unwieldy, including a split in the plan is reasonable.

This structure informs the task decomposition. Each task should produce self-contained changes that make sense independently.

## Task Right-Sizing

A task is the smallest unit that carries its own test cycle and is worth a
fresh reviewer's gate. When drawing task boundaries: fold setup,
configuration, scaffolding, and documentation steps into the task whose
deliverable needs them; split only where a reviewer could meaningfully
reject one task while approving its neighbor. Each task ends with an
independently testable deliverable.

## Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**
- Standard mode: "Implement one behavior" - step
- Standard mode: "Add or update its automated tests" - step
- TDD mode: "Write the failing test" - step
- TDD mode: "Run it to make sure it fails" - step
- TDD mode: "Implement the minimal code to make the test pass" - step
- Either mode: "Run the relevant tests and make sure they pass" - step
- "Read the Task files and verify their logic against the Task requirements" - step

Every Task MUST end with the file-reading verification step, after all of its
implementation and test steps.

## Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

**Testing:** [Standard, or TDD — name the explicit request/spec requirement when TDD]

**Spec:** [exact path, or `none — requirements: <approved requirements stated once>`]

## Global Constraints

[The requirements authority's project-wide requirements — version floors,
dependency limits, naming and copy rules, platform requirements — one line
each, with exact values copied from the spec or approved requirements. Every
task's requirements implicitly include this section.]

---
```

## Task Structure

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Interfaces:**
- Consumes: [what this task uses from earlier tasks — exact signatures]
- Produces: [what later tasks rely on — exact function names, parameter
  and return types. A task's implementer sees only their own task; this
  block is how they learn the names and types neighboring tasks use.]

**Testing:** [Copy the plan's Standard or TDD mode exactly]

Include exactly one of the following step sequences in the generated task.
Never copy both branches into a plan.

**If Testing is TDD:**

- [ ] **Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

- [ ] **Step 2: Run test to verify it fails**

Run: `pytest tests/path/test.py::test_name -v`
Expected: FAIL with "function not defined"

- [ ] **Step 3: Write minimal implementation**

```python
def function(input):
    return expected
```

- [ ] **Step 4: Run test to verify it passes**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

**If Testing is Standard:**

- [ ] **Step 1: Implement the requested behavior**

```python
def function(input):
    return expected
```

- [ ] **Step 2: Add or update automated tests**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

- [ ] **Step 3: Run the relevant tests**

Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS

For changes where an automated test is not applicable, replace the test step
with the exact validation command and expected result. Do not label standard
testing steps as RED, GREEN, test-first, or TDD.

**Both modes end with:**

- [ ] **Final Step: Read the Task files and verify the implementation**

Read the latest contents of every file listed in this Task's **Files** section.
Inspect the changed functions, classes, and their directly affected call sites
against the Task's stated requirements, every implementation step, applicable
**Global Constraints**, and the **Interfaces** contract. For new files, read
the complete file.

Run only the non-mutating diagnostics permitted by the plan's Global
Constraints, with exact paths and expected output. For example:

```bash
git diff --check -- tests/path/test.py src/path/file.py
```

Expected: state the concrete behavior and interfaces that should be present in
the files after this Task, plus the diagnostics result. The checkpoint judges
the implementation by reading the files; it makes no claim about what other
changes are or are not present in the working tree. If the execution workflow
later produces a review package, reviewers may use it as additional input; it
does not replace reading and understanding the Task files.

The plan does not prescribe a generic staging or commit policy and contains no
`git add` or `git commit` steps. The selected execution workflow owns its Git
lifecycle: Subagent-Driven follows its isolated-worktree and per-task commit
contract; Inline Execution does not create commits unless the human partner
explicitly asks for them.
````

## No Placeholders

Every step must contain the actual content an engineer needs. These are **plan failures** — never write them:
- "TBD", "TODO", "implement later", "fill in details"
- "Add appropriate error handling" / "add validation" / "handle edge cases"
- "Write tests for the above" (without actual test code)
- "Similar to Task N" (repeat the code — the engineer may be reading tasks out of order)
- Steps that describe what to do without showing how (code blocks required for code steps)
- References to types, functions, or methods not defined in any task

## Remember
- Exact file paths always
- Complete code in every step — if a step changes code, show the code
- Exact commands with expected output
- DRY, YAGNI, the selected testing mode, frequent verification checkpoints
- Git staging and commit policy belongs to the selected execution workflow;
  the plan does not override it

## Self-Review

After writing the complete plan, look at its requirements authority with fresh
eyes and check the plan against it. Use the spec when one exists; otherwise use
the approved requirements in the plan header and its Global Constraints. This
is a checklist you run yourself — not a subagent dispatch.

**1. Requirements coverage:** Skim every requirement in the selected authority.
Can you point to a task that implements it? List any gaps.

**2. Placeholder scan:** Search your plan for red flags — any of the patterns from the "No Placeholders" section above. Fix them.

**3. Type consistency:** Do the types, method signatures, and property names you used in later tasks match what you defined in earlier tasks? A function called `clearLayers()` in Task 3 but `clearFullLayers()` in Task 7 is a bug.

If you find issues, fix them inline. No need to re-review — just fix and move
on. If you find a requirement with no task, add the task.

## Plan Review

After the complete plan passes Self-Review:

1. Dispatch exactly one read-only general-purpose plan reviewer using
   `plan-document-reviewer-prompt.md`.
2. Give it the plan path and exactly one requirements authority:
   - the spec path, when a spec exists; or
   - `No spec exists; use the approved requirements in the plan header and the
     plan's Global Constraints.`
3. If it reports implementation-blocking findings, fix them in the plan and
   repeat Self-Review.
4. Do not dispatch another reviewer by default. Continue to Execution Handoff
   after the controller's fixes and self-review.

The reviewer is read-only. The controller remains responsible for every plan
edit.

## Execution Handoff

If Brainstorming recorded direct-start, do not show the choices. Select the
safest suitable executor after Plan Review and continue: prefer
Subagent-Driven for independent tasks with available subagents; otherwise use
Inline Execution.

Otherwise, after saving the plan, offer execution choice:

Use this exact response shape so the human partner can copy the plan path:

**Plan complete and saved to:**

```
docs/superpowers/plans/<filename>.md
```

**Three execution options:**

**1. Subagent-Driven (recommended)** - I dispatch a fresh subagent per task, review between tasks, fast iteration

**2. Inline Execution** - Execute tasks in this session using executing-plans, batch execution with checkpoints

**3. Do Nothing** - Leave the plan saved without starting implementation

**Which approach?**

**If Subagent-Driven chosen:**
- **REQUIRED SUB-SKILL:** Use superpowers:subagent-driven-development
- Fresh subagent per task + two-stage review

**If Inline Execution chosen:**
- **REQUIRED SUB-SKILL:** Use superpowers:executing-plans
- Batch execution with checkpoints for review
