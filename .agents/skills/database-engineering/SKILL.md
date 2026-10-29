---
name: database-engineering
description: >
  Design, query, and safely change relational data models, SQL, migrations,
  indexes, and access policies. Use for PostgreSQL, Supabase, SQLite, MySQL,
  ORM data access, or data-integrity work.
---

# Database Engineering

Inspect schema files, migrations, ORM models, indexes, row-level security rules, and database configuration before proposing changes. Confirm the actual engine and version from project evidence.

## Work method

- Model entities, cardinality, constraints, nullability, and ownership from verified requirements.
- Use parameterized queries and least-privilege access; never interpolate untrusted input into SQL.
- Make migrations explicit, reviewable, and reversible where feasible. Describe data-loss or lock risks before destructive changes.
- Consider indexes against real query patterns; avoid speculative indexing.
- For Postgres/Supabase, review RLS policies alongside application-level authorization. Never assume RLS is enabled or correct.
- Separate schema design from live data inspection. Do not access or alter a live database without explicit authorization.
- Preserve tenant/customer boundaries and avoid leaking one client's records into another project.
- For other SQL dialects, check the project's exact dialect and official docs before using engine-specific syntax.

Follow the user's test authorization. Do not add or run tests unless asked. Never claim a migration was applied unless observed.
