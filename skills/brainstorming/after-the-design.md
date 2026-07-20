# After the Design

Use this reference after design approval, or after direct-start context analysis, when deciding whether to write a spec or move into planning and implementation.

## Documentation

- Write the validated design (spec) to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md` only when a design doc is actually needed
  - User preferences for spec location override this default
  - Medium tasks usually skip this unless they are especially complex
- Use elements-of-style:writing-clearly-and-concisely skill if available

## Spec Self-Review

After writing the spec document, look at it with fresh eyes:

1. **Placeholder scan:** Any "TBD", "TODO", incomplete sections, or vague requirements? Fix them.
2. **Internal consistency:** Do any sections contradict each other? Does the architecture match the feature descriptions?
3. **Scope check:** Is this focused enough for a single implementation plan, or does it need decomposition?
4. **Ambiguity check:** Could any requirement be interpreted two different ways? If so, pick one and make it explicit.

Fix any issues inline. No need to re-review - just fix and move on.

## User Review Gate

If you wrote a design doc, ask the user to review the written spec before proceeding:

> "Spec written to `<path>`. Please review it and let me know if you want to make any changes before we start writing out the implementation plan."

Wait for the user's response. If they request changes, make them and re-run the spec review loop. Only proceed once the user approves.

## Implementation

- If the work is small, local, and non-complex, start the requested follow-up work directly from the approved design on the default path, or directly after direct-start context analysis on the direct-start path
- In that direct path, do NOT write a design spec and do NOT invoke `superpowers:writing-plans`
- Before claiming completion on that path, follow the closing discipline from `superpowers:executing-plans`
- That means borrow its final self-review and verification discipline only; do NOT invoke `superpowers:executing-plans` unless you already have an approved written implementation plan
- After that final self-review and verification pass, ask the user whether they want code review
- This is a closing consent gate, not a dialogue-only brainstorming item; direct-start alone does not skip it
- If the user already explicitly requested code review for this point, invoke `superpowers:requesting-code-review` without asking again
- If the user already explicitly declined or prohibited code review, complete normally without asking
- Do not dispatch a review subagent or recreate review steps from memory before invoking `superpowers:requesting-code-review`
- Do not invoke `superpowers:requesting-code-review` unless the user says yes or already gave that explicit authorization
- If the work is larger or uncertain, invoke `superpowers:writing-plans` to create a detailed implementation plan
- If a larger design was already approved in chat, you may move straight into `superpowers:writing-plans` without creating a spec first
- If you already wrote a design doc, the user must still review it before you begin any follow-up work

## Plan Execution Handoff

Invoking `superpowers:writing-plans` authorizes plan creation, not plan
execution. Preserve the two authorization states recorded during brainstorming:

- With explicit `continuous-execution`, continue after the plan using the
  user's selected workflow, or `superpowers:subagent-driven-development` when
  no workflow was selected.
- Without `continuous-execution`, return the saved plan path and the execution
  choices from `superpowers:writing-plans`, ask the user to choose, and end the
  turn. Start implementation only after that choice or an explicit request to
  execute the plan.

A direct-start-only override skips brainstorming dialogue; it does not skip the
plan execution handoff.
