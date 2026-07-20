# Anti-Rationalizations

Use this reference when pressure, urgency, or apparent simplicity makes it tempting to skip brainstorming steps.

## Rationalization Table

| Rationalization | Reality |
|-----------------|---------|
| "This is tiny, so I can skip design approval." | Size affects how short the design can be, not whether approval is required. Unless the user explicitly authorizes direct-start, stay on the default path and wait for approval before implementation. |
| "The user named the file and exact change, so they clearly want me to just do it." | File paths, diffs, and precise edit instructions describe **what** to change. They do not waive brainstorming, design presentation, or approval. |
| "They said implement/fix/update/add, which means start now." | Task verbs describe the requested outcome. They are not an explicit direct-start override. |
| "I already checked context and it looks safe, so I can go straight from exploration to coding." | Exploring context is step 1, not a substitute for step 5. On the default path, context review still leads to clarifying questions, approaches, and presented design before coding. |
| "I know what the design should be, so I don't need to show it." | Internal reasoning is not user approval. The design must be presented in chat and approved unless the user explicitly overrides that requirement. |
| "It's urgent, release is today, or the change is low-risk, so asking first would be wasteful." | Time pressure, confidence, and low perceived risk do not remove the gate. Only an explicit direct-start override changes the workflow. |
| "They said start directly, so I can execute as soon as the plan is written." | Direct-start skips brainstorming dialogue only. Unless the user explicitly authorized continuous execution, return the plan's execution choices and wait for a selection. |
| "Subagent-driven is recommended, so I can choose it for them." | A recommendation is the default only under explicit continuous execution. Otherwise it is an option the user must select. |
| "The plan is clear, context is fresh, and stopping would waste time." | Readiness and urgency do not create execution authorization. Without continuous execution, the plan handoff response ends with the execution-choice question. |
| "I can combine the Visual Companion offer with questions or other discussion to save a turn." | When visual questions are likely, offer the Visual Companion in its own message only. Do not bundle that offer with other content. |

## Red Flags

If you catch yourself thinking any of these, STOP and return to the documented flow:

- "This is too small to need a design."
- "The file path is already specified, so brainstorming would be performative."
- "Implement/fix/add means I have implied permission to start."
- "I can think through the design silently and code right away."
- "I'll inspect context first, then skip the approval step if it still looks obvious."
- "This deadline is too tight to wait for approval."
- "Direct-start also means execute the plan automatically."
- "Recommended means I can select the executor myself."
- "The plan is ready, so the handoff question is not a real gate."
- "I'll offer the Visual Companion and continue the rest of the discussion in the same message."

**All of these mean:** return to the applicable gate. Before design, stay on the
default path until approval or an explicit direct-start override. After plan
creation, wait for an execution choice unless you can quote explicit
continuous-execution wording.
