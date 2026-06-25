#!/usr/bin/env bash
# Test: subagent-driven-development skill
# Verifies that the skill is loaded and follows correct workflow
#
# No drill coverage: this test asks the agent to *describe* SDD (string-
# matches its verbal explanation against expected keywords like
# "self-review", "skeptical", "worktree", "Step 1", "loop"). Drill scenarios
# test behavior (real subagent dispatch, plan-following, review loops),
# not description-recall. Kept by design.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

CLAUDE_PROMPT_TIMEOUT="${CLAUDE_PROMPT_TIMEOUT:-90}"

echo "=== Test: subagent-driven-development skill ==="
echo ""

# Test 1: Verify skill can be loaded
echo "Test 1: Skill loading..."

output=$(run_claude "What is the subagent-driven-development skill? Describe its key steps briefly." "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "subagent-driven-development\|Subagent-Driven Development\|Subagent Driven" "Skill is recognized"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Load Plan\|Read.*plan\|read.*plan\|Extract.*tasks\|extract.*tasks\|读取.*计划\|提取.*任务" "Mentions loading plan"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 2: Verify skill describes the v6 task review shape
echo "Test 2: Task review shape..."

output=$(run_claude "In the subagent-driven-development skill, what does the per-task reviewer report? Answer using exactly this structure:
Spec verdict: <what it reports>
Quality verdict: <what it reports>" "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "Spec verdict:.*spec\|Spec verdict:.*compliance\|Spec verdict:.*规格\|Spec verdict:.*需求" "Reports spec verdict"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Quality verdict:.*quality\|Quality verdict:.*approved\|Quality verdict:.*质量\|Quality verdict:.*批准" "Reports quality verdict"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 3: Verify self-review is mentioned
echo "Test 3: Self-review requirement..."

output=$(run_claude "Does the subagent-driven-development skill require implementers to self-review before handoff, and can self-review replace the external reviews? Answer using exactly this structure:
Self-review required: <yes or no>
Self-review replaces external review: <yes or no>" "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "Self-review required:.*yes\|Self-review required:.*是" "Mentions self-review"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Self-review replaces external review:.*no\|Self-review replaces external review:.*否" "Self-review does not replace external review"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 4: Verify plan is read once
echo "Test 4: Plan reading efficiency..."

output=$(run_claude "In subagent-driven-development, how many times should the controller read the plan file? When does this happen?" "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "once\|one time\|single\|一次" "Read plan once"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Step 1\|beginning\|start\|Load Plan\|开始\|一开始\|准备阶段" "Read at beginning"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 5: Verify spec compliance reviewer is skeptical
echo "Test 5: Spec compliance reviewer mindset..."

output=$(run_claude "What is the spec compliance reviewer's attitude toward the implementer's report in subagent-driven-development?" "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "not trust\|don't trust\|skeptical\|verify.*independently\|suspiciously\|不.*信任\|怀疑\|独立.*验证" "Reviewer is skeptical"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "read.*diff\|inspect.*diff\|review-package\|read.*code\|inspect.*code\|读取.*diff\|审查包\|读取.*代码" "Reviewer reads review evidence"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 6: Verify review loops
echo "Test 6: Review loop requirements..."

output=$(run_claude "In subagent-driven-development, what happens if a reviewer finds issues? Is it a one-time review or a loop?" "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "loop\|again\|repeat\|until.*approved\|until.*compliant\|循环\|再次\|重复\|直到.*通过" "Review loops mentioned"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "implementer.*fix\|fix.*issues\|fix subagent\|修复.*子代理\|实施者.*修复" "Fixer handles issues"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 7: Verify full task text is provided
echo "Test 7: Task context provision..."

output=$(run_claude "In subagent-driven-development, how does the controller provide task information to the implementer subagent? Answer using exactly this structure:
Controller provides: <directly or by file>
Implementer must read plan file: <yes or no>" "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "Controller provides:.*file\|task-brief\|brief.*file\|文件\|任务简报" "Provides task brief by file"; then
    : # pass
else
    exit 1
fi

if assert_contains "$output" "Implementer must read plan file:.*no\|Implementer must read plan file:.*否" "Doesn't make subagent read plan file"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 8: Verify worktree requirement
echo "Test 8: Worktree requirement..."

output=$(run_claude "What workflow skills are required before using subagent-driven-development? List any prerequisites or required skills." "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "using-git-worktrees\|worktree" "Mentions worktree requirement"; then
    : # pass
else
    exit 1
fi

echo ""

# Test 9: Verify main branch warning
echo "Test 9: Main branch red flag..."

output=$(run_claude "In subagent-driven-development, is it okay to start implementation directly on the main branch?" "$CLAUDE_PROMPT_TIMEOUT")

if assert_contains "$output" "worktree\|feature.*branch\|not.*main\|never.*main\|avoid.*main\|don't.*main\|consent\|permission" "Warns against main branch"; then
    : # pass
else
    exit 1
fi

echo ""

echo "=== All subagent-driven-development skill tests passed ==="
