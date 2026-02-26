# 003: Knowledge Capture

## Overview

When facts are verified (CONFIRMED or PARTIALLY TRUE), save them to the user's local knowledge base. Knowledge is stored at the fact level, not article level.

## What Gets Saved

Each verified fact becomes a knowledge entry:

| Field | Description |
|-------|-------------|
| `fact` | The specific claim that was verified |
| `verdict` | confirmed / partially_true |
| `summary` | What we found (2-3 sentences) |
| `sources` | List of sources checked |
| `context` | Any important caveats or nuance |
| `original_article` | Link to the article this came from |
| `date_verified` | When we verified it |

**Example entry:**
```
Fact: "Google's A2A protocol complements MCP, not replaces it"
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

- ❌ BUSTED facts — user doesn't need to remember false info
- ❌ UNVERIFIED facts — not enough evidence
- ❌ Opinions — not factual claims
- ❌ The original article itself — just the extracted facts

## Storage

Local SQLite database. Simple, no cloud, no dependencies.

Location: `~/.rumor-busted/knowledge.db`

## User Interactions

### After Verification

When facts are verified and saved:
> "Saved 2 verified facts to your knowledge base."

### Viewing Knowledge

User can ask to see their saved knowledge:
> "Show my saved facts" / "What do I know?"

Response: List of recent verified facts with summaries.

## Out of Scope (MVP)

- Searching/querying knowledge base
- Tagging or categorizing facts
- Exporting knowledge
- Syncing across devices
- Deleting individual entries

## Acceptance Criteria

- [ ] Verified facts (confirmed/partially_true) are saved automatically
- [ ] Each fact is stored with verdict, summary, sources, and context
- [ ] User can view their saved knowledge
- [ ] Busted/unverified facts are NOT saved
