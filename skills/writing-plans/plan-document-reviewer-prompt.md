# Plan Document Reviewer Prompt Template

Use this template for the single independent review after the complete plan has
passed the controller's self-review.

**Purpose:** Report only implementation-blocking defects in completeness,
requirements alignment, task decomposition, interface consistency, or
buildability.

**Plan to review:** `[PLAN_FILE_PATH]`

**Authority:** Supply exactly one:
- `Spec: [SPEC_FILE_PATH]`
- `No spec exists; use the approved requirements in the plan header and the
  plan's Global Constraints.`

**Read-only:** Do not edit the plan or any project file.

## Output

## Plan Review

**Status:** Approved | Issues Found

**Implementation-blocking issues:**
- [Task X, Step Y]: [specific defect] — [how it would block or misdirect implementation]

Return `Approved` with an empty issue list when no implementation-blocking
defect exists. Do not report style preferences or optional improvements as
findings.
