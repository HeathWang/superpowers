---
name: executing-plans
description: Use when you have an approved written implementation plan and need to carry it out after planning is complete
---

# Executing Plans

## Overview

Load plan, review critically, choose the correct in-session execution mode, execute all tasks, then read the resulting changes and do one final self-review before completion.

**Core principle:** Default to sequential execution, but always evaluate whether the plan can be safely decomposed into non-interfering edit-domain groups. Use grouped subagents in the current workspace only when those groups are real, safe, and substantial enough to justify dispatch overhead, then finish with one explicit self-review pass over the final changes before completion.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

**Context:** Use this after plan approval, whether continuing immediately in the current session or resuming later from the saved plan.

**Execution mode:** Stay in this session. Do not switch to `superpowers:subagent-driven-development` as part of this skill. Do not create a git worktree as part of this skill. If you use subagents here, use them only as grouped implementers in the current workspace, not as the separate workflow defined by `superpowers:subagent-driven-development`.

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. Inventory the `### Task N:` sections
4. Extract the files, responsibilities, verification targets, and ordering constraints for each Task
5. If concerns: Raise them with your human partner before starting
6. If no concerns: Create TodoWrite and choose the execution mode

### Step 2: Choose Execution Mode

Use this decision order:

1. Form tentative Task groups by edit domain before choosing the execution mode
2. If you cannot form 2 or more safe groups: execute sequentially
3. If you can form 2 or more safe groups, decide whether grouped subagents would reduce total execution time without increasing coordination risk
4. Use grouped subagents only if those groups can be separated cleanly by edit domain and are substantial enough to justify dispatch overhead
5. If the groups are tiny, mostly mechanical, or faster to complete directly in the parent session: stay sequential
6. When in doubt, stay sequential

Group by edit domain, not by Task number:

- Tasks that touch the same file, the same module boundary, the same verification target, or the same ordered rollout path belong in the same group
- Tasks with direct ordering dependencies belong in the same group or must run in a serialized batch
- When grouped subagent mode is active, combine non-interfering Tasks into the fewest sensible groups instead of dispatching one subagent per Task
- Task count alone does not determine the execution mode
- When in doubt about interference or dispatch overhead, keep the work serialized

### Step 3: Execute All Tasks

If using sequential mode:
1. For each Task in sequence, mark it as in_progress
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark the Task as completed

If using grouped subagent mode:
1. Form the Task groups before dispatching any subagent
2. Verify that groups do not overlap in files, verification targets, or ordering dependencies
3. Dispatch one implementer subagent per group, not per Task
4. Have each implementer execute that group's Tasks sequentially in the current workspace
5. Only run groups in parallel when they are truly non-interfering; otherwise run the groups in serialized batches
6. Never create a git worktree for this mode
7. Mark each Task complete only after its group's implementation and verification are done

Continue until all coding tasks are complete.

### Step 4: Read Latest Files and Self-Review

After all tasks complete:
1. Read all modified/created files
2. Verify the implementation is comprehensive:
   - All requirements from the plan are met
   - Code quality and structure are sound
   - Edge cases are handled
   - Documentation is updated
3. Identify any gaps or issues that need addressing
4. Fix anything important you find during this pass
5. Re-run any relevant verification needed after the fixes

This is a single self-review pass over the actual changed files. Do not escalate to a code-review subagent unless your human partner explicitly asks for one.

### Step 5: Finalize Implementation

Based on the self-review:
- Address any identified gaps or issues
- Ensure all verifications pass
- Confirm implementation is complete and ready only after reading the changed files and checking them against the plan

### Step 6: Complete Development

After all tasks complete, are verified, and pass the self-review:
- Summarize all completed tasks
- Output a summary of what content was changed

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You cannot tell whether Task groups are actually non-interfering
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Task grouping assumptions turn out to be wrong once you inspect the real files
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Default to sequential execution
- Always evaluate grouping by edit domain before choosing the execution mode
- Use grouped subagents only when you can form 2 or more non-interfering groups and those groups are substantial enough to justify dispatch overhead
- Don't use raw Task count as the deciding signal
- Don't switch to `superpowers:subagent-driven-development` or create a git worktree as part of this skill
- Don't dispatch one subagent per Task when grouped mode is active
- Don't split Tasks that share files, verification targets, or ordering dependencies across different groups
- Don't run overlapping groups in parallel
- Don't skip reading the final changed files
- Don't proceed with unfixed Important or Critical issues found during self-review
- Don't claim completion before self-review and verification
- Stop when blocked, don't guess

## Integration

**Required workflow skills:**
- **superpowers:writing-plans** - Creates the plan this skill executes
