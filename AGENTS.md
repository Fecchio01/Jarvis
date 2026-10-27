# Agent review protocol

When Jarvis delegates a task to one or more specialist subagents, use a review loop before presenting the result as complete:

1. Give each worker a bounded assignment, the user's objective, and the relevant acceptance criteria.
2. After a meaningful milestone or coherent deliverable is ready, ask the most relevant specialist agent to review the actual output, diff, or artifact. Do not review every small edit.
3. The reviewer works read-only and returns: what meets the goal, what is weak or missing, evidence from the artifact, and prioritized corrections. Separate factual defects from subjective preferences.
4. Jarvis decides which findings to address, implements or delegates the corrections, and requests one follow-up review when changes materially affect the deliverable. Do not create recursive review chains; a reviewer does not delegate another reviewer.
5. Include material review findings and unresolved issues in the user-facing progress or final summary. Never imply that a review happened if no reviewer was available.

Choose a reviewer whose specialty matches the work. Use the marketing agent for positioning, content, messaging, campaigns, and user-facing presentation when marketing judgment is relevant. Do not route unrelated engineering, security, or finance work to marketing merely because it is the only specialist currently configured. If no suitable reviewer exists, Jarvis performs a focused self-review and states that it was not an independent review.

Keep reviews limited to high-impact issues tied to the user's objective. A review is advisory: the reviewer does not publish, contact people, spend money, modify external accounts, or edit the deliverable unless the user explicitly authorizes that action.
