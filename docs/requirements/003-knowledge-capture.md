# 003: Knowledge Capture

## Overview

When a say is verified (CONFIRMED or PARTIALLY TRUE), save it to the user's local knowledge base. Knowledge is stored per say, not per article.

## What Gets Saved

Each verified say becomes a knowledge entry:

| Field | Description |
|-------|-------------|
| `say` | What the article said |
| `verdict` | confirmed / partially_true |
| `summary` | What we found (2-3 sentences) |
| `sources` | List of sources checked |
| `context` | Any important caveats or nuance |
| `original_article` | Link to the article this came from |
| `date_verified` | When we verified it |

**Example entry:**
```
Say: "Google's A2A protocol complements MCP, not replaces it"
Verdict: confirmed
Summary: Google's A2A announcement explicitly states it "complements 
         Anthropic's Model Context Protocol (MCP)". A2A is for 
         agent-to-agent communication; MCP is for model-to-tool.
Sources:
  - developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/
Context: Different protocols for different purposes
Original: [link to the article user submitted]
Date: 2026-02-26
```

## What Does NOT Get Saved

- ❌ BUSTED say — user doesn't need to remember false info
- ❌ UNVERIFIED say — not enough evidence
- ❌ OPINION say — subjective, not knowledge
- ❌ The original article itself — just the verified say

## Storage

Local SQLite database. Simple, no cloud, no dependencies.

Location: `~/.rumor-busted/knowledge.db`

## User Interactions

### After Verification

When say is verified and saved:
> "Saved 2 verified say to your knowledge base."

### Viewing Knowledge

User can ask to see their saved knowledge:
> "Show my knowledge" / "What do I know?"

Response: List of recent verified say with summaries.

## Out of Scope (MVP)

- Searching/querying knowledge base
- Tagging or categorizing
- Exporting knowledge
- Syncing across devices
- Deleting individual entries

## Acceptance Criteria

- [ ] Verified say (confirmed/partially_true) are saved automatically
- [ ] Each say is stored with verdict, summary, sources, and context
- [ ] User can view their saved knowledge
- [ ] Busted/unverified/opinion say are NOT saved
