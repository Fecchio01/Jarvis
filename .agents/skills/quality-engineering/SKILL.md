---
name: quality-engineering
description: >
  Review software quality, reproduce defects, identify regressions, and plan
  verification. Use for requested QA reviews, bug triage, acceptance checks,
  or test work explicitly authorized by the user.
---

# Quality Engineering

Base QA conclusions on the requested behavior, repository code, and observable evidence. Inspect the project's test/build setup before recommending a verification path.

## Work method

- Translate requirements into observable acceptance criteria and edge cases.
- Distinguish a confirmed defect from an unverified risk or subjective preference.
- Review changed paths for regressions, error handling, security boundaries, and important UI states.
- When testing is authorized, use the existing project's test tools and report exact commands/results; do not add a new framework without need.
- Without authorization to run/add tests, provide a test plan or static review only.
- Do not use production customer data as fixtures; use synthetic examples.
- Prioritize findings by consequence and include file/line evidence or reproduction steps.

Do not change production systems or sign off a release unless explicitly authorized. Report coverage limitations and unverified behavior.
