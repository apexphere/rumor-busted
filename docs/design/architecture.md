# 002: Architecture Decisions for MVP

## Overview

Keep it simple. Local-first. No cloud dependencies.

---

## Decision 1: Knowledge Base Storage

**Choice: SQLite file**

That's it. A single `.db` file on your machine.

```
~/.rumor-busted/knowledge.db
```

**Why:**
- Zero setup
- Zero dependencies
- Zero cost
- Works offline
- Easy to backup (it's just a file)
- Easy to inspect (`sqlite3 knowledge.db`)

**Schema:**
```sql
CREATE TABLE knowledge (
  id TEXT PRIMARY KEY,
  claim TEXT NOT NULL,
  verdict TEXT NOT NULL,  -- 'confirmed' | 'partially_true'
  summary TEXT NOT NULL,
  sources TEXT,           -- JSON array of URLs
  original_link TEXT,
  tags TEXT,              -- JSON array
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
```

**Swap later?** Abstract behind a repository interface. But don't build that until we need it.

---

## Decision 2: Entry Point

**Choice: WhatsApp via local OpenClaw gateway**

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  WhatsApp   │ ──► │  OpenClaw   │ ──► │ Rumor Busted│
│   (phone)   │     │  Gateway    │     │   Skill     │
└─────────────┘     │  (local)    │     └─────────────┘
                    └─────────────┘            │
                                               ▼
                                        ┌─────────────┐
                                        │   SQLite    │
                                        │ (local file)│
                                        └─────────────┘
```

**How it works:**
1. You send a link to WhatsApp
2. OpenClaw receives it, triggers Rumor Busted skill
3. Skill researches the claim (web_fetch, etc.)
4. Returns verdict
5. If confirmed → saves to local SQLite

---

## Decision 3: What We're Building

An **OpenClaw skill** with:
- `SKILL.md` — prompts and workflow
- `mcp.json` — MCP server config (optional, for tools)
- Simple MCP server with tools:
  - `verify_claim` — research a link/claim
  - `save_to_knowledge` — store verified fact
  - `list_knowledge` — show saved facts
  - `search_knowledge` — find past facts

Or even simpler for v0: just the skill file, use OpenClaw's built-in `web_fetch` for research, shell out to `sqlite3` for storage.

---

## Summary

| What | Choice |
|------|--------|
| Storage | SQLite file (`~/.rumor-busted/knowledge.db`) |
| Interface | WhatsApp → OpenClaw (local) |
| Deployment | Your laptop |
| Cloud | None |
| Auth | None (single user) |

---

## Next Steps

1. Create the skill (`SKILL.md`)
2. Init the SQLite database
3. Test via WhatsApp

