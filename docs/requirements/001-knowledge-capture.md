# 001: Knowledge Capture from Verified Claims

## Overview

When Rumor Busted verifies a claim as true, automatically save it to the user's personal knowledge base. This turns fact-checking into knowledge building.

## User Story

> As a user, I want verified facts saved to my knowledge base, so I can reference them later without re-researching.

## Workflow

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  User shares    │ ──► │  Rumor Busted   │ ──► │    Verdict      │ ──► │ Save to KB if   │
│  link/claim     │     │  researches     │     │    delivered    │     │ TRUE/CONFIRMED  │
└─────────────────┘     └─────────────────┘     └─────────────────┘     └─────────────────┘
```

### Step-by-Step

1. **User sees claim** — social media post, article, hot take
2. **User shares link** — sends to Rumor Busted (via chat, app, extension)
3. **Research phase** — Rumor Busted traces sources, checks facts
4. **Verdict delivered** — Busted / Confirmed / Partially True
5. **Knowledge capture** — If Confirmed (true), save to user's knowledge base

## What Gets Saved

For verified/confirmed claims:

| Field | Description |
|-------|-------------|
| `claim` | The core claim being verified |
| `verdict` | Confirmed / Partially True |
| `summary` | Brief explanation of findings |
| `sources` | Links to primary sources |
| `date_verified` | When we verified it |
| `original_link` | The link user shared |
| `tags` | Auto-generated topic tags |

## Example

**Input:** User shares tweet saying "Google's A2A protocol complements MCP, not replaces it"

**Research:** Check Google's official A2A announcement

**Verdict:** ✅ Confirmed

**Saved to KB:**
```yaml
claim: "Google's A2A protocol complements MCP"
verdict: confirmed
summary: "Google's A2A (Agent2Agent) protocol is designed for agent-to-agent communication. Official announcement explicitly states it 'complements Anthropic's Model Context Protocol (MCP), which provides helpful tools and context to agents.'"
sources:
  - https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/
date_verified: 2026-02-26
tags: [AI, protocols, MCP, A2A, Google]
```

## Out of Scope (v1)

- Busted claims are NOT saved (user doesn't need to remember false info)
- No sharing/exporting knowledge base (future feature)
- No cross-user knowledge (privacy first)

## Open Questions

1. **What is the "knowledge base"?** — Local storage? Cloud sync? Integration with existing tools (Notion, Obsidian)?
2. **User control** — Can user opt-out of auto-save? Delete entries?
3. **Duplicates** — How to handle if user submits same claim twice?

## Acceptance Criteria

- [ ] User can submit a link or claim for verification
- [ ] System researches and returns verdict with sources
- [ ] Confirmed claims are automatically saved to user's knowledge base
- [ ] User can view their saved knowledge
- [ ] User can delete entries from their knowledge base
