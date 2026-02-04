---
name: executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute all tasks sequentially, then do overall comprehensive review.

**Core principle:** Sequential execution with final comprehensive review.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute All Tasks

For each task in sequence:
1. Mark as in_progress
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark as completed

Continue until all coding tasks are complete.

### Step 3: Read Latest Files and Overall Review

After all tasks complete:
1. Read all modified/created files
2. Verify the implementation is comprehensive:
   - All requirements from the plan are met
   - Code quality and structure are sound
   - Edge cases are handled
   - Documentation is updated
3. Identify any gaps or issues that need addressing

### Step 4: Finalize Implementation

Based on overall review:
- Address any identified gaps or issues
- Ensure all verifications pass
- Confirm implementation is complete and ready

### Step 5: Complete Development

After all tasks complete and verified:
- Summarize all completed tasks
- Output a summary of what content was changed

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Execute all tasks sequentially before doing overall review
- Stop when blocked, don't guess
- Never start implementation on main/master branch without explicit user consent

## Integration

**Required workflow skills:**
- **superpowers:writing-plans** - Creates the plan this skill executes
