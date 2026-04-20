---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write implementation plans for engineers with almost no context for the codebase. Spell out the exact files, code, tests, supporting docs, and verification they need, then break the work into bite-sized tasks.

Assume the executor is technically capable but unfamiliar with the project and weak at test design.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

**Context:** Write and refine the plan in the current branch and current workspace unless the user explicitly asks for a different setup.

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`
- (User preferences for plan location override this default)

## Scope Check

If the spec covers multiple independent subsystems, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for. This is where decomposition decisions get locked in.

- Design small units with clear interfaces. Each file should do one job.
- You reason best about code you can hold in context at once, and your edits are more reliable when files are focused. Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns. Don't restructure unrelated code, but splitting an unwieldy file you're already touching is reasonable.

Use this file map to decompose the plan into self-contained tasks.

## Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**
- "Write the minimal implementation for one requirement" - step
- "Run the smallest relevant verification" - step
- "Refine code structure only if necessary" - step
- "Confirm the task outcome" - step

## Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Steps use checkbox (`- [ ]`) syntax for tracking. After saving the plan, stop and ask the user to review it before implementation continues.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

---
```

## Task Structure

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Step 1: Write minimal implementation**

```python
def function(input):
    return expected
```

**Step 2: Run verification to confirm behavior**

Run: `[project-appropriate verification command]`
Expected: behavior matches requirement

```

## Remember
- Exact file paths always
- Complete code in plan (not "add validation")
- Exact commands with expected output
- Reference relevant skills with @ syntax
- DRY, YAGNI, minimal scope, frequent commits

## Execution Handoff

After saving the plan:

**"Plan complete and saved to `docs/superpowers/plans/<filename>.md`. Please review it and share any requested changes, or approve continuing."**

**If the user requests changes:**
- Update the plan and stop again for review

**If the user approves continuing:**
- **REQUIRED SUB-SKILL:** Use superpowers:executing-plans
- Stay in this session and hand execution to `superpowers:executing-plans`
- Let `superpowers:executing-plans` choose the correct in-session execution mode from the approved plan
