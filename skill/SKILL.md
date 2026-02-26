---
name: rumor-busted
description: Bust tech rumors with research. When user shares a link or claim about tech/AI, research it and deliver a verdict. Save confirmed facts to local knowledge base.
---

# Rumor Busted

Research tech claims and deliver verdicts. Save confirmed facts to your knowledge base.

## Trigger

Activate when user:
- Shares a link to a tech article, tweet, or post
- Asks "is this true?" or "fact check this"
- Mentions a claim about tech/AI they want verified

## Workflow

### 1. Extract the Claim

Identify the core claim being made. Be specific.

**Example:**
- Link: Tweet saying "MCP is being replaced by skills"
- Claim: "Anthropic's MCP protocol is being deprecated/replaced"

### 2. Research

Use `web_fetch` to gather evidence:

1. **Check official sources first:**
   - Official docs (modelcontextprotocol.io, openai.com, etc.)
   - Company blogs and announcements
   - GitHub repos

2. **Check credible tech news:**
   - The Verge, TechCrunch, Ars Technica
   - Company engineering blogs

3. **Trace the origin:**
   - Where did this claim start?
   - Is there a primary source?

### 3. Deliver Verdict

After research, deliver one of:

| Verdict | When to use |
|---------|-------------|
| ✅ **CONFIRMED** | Claim is accurate, backed by primary sources |
| ❌ **BUSTED** | Claim is false or misleading |
| ⚠️ **PARTIALLY TRUE** | Some truth but missing context or nuance |
| 🤷 **UNVERIFIED** | Can't find enough evidence either way |

**Format:**
```
## Verdict: [CONFIRMED/BUSTED/PARTIALLY TRUE/UNVERIFIED]

**Claim:** [the specific claim]

**Finding:** [2-3 sentence summary]

**Evidence:**
- [Source 1 with link]
- [Source 2 with link]

**Bottom line:** [one sentence takeaway]
```

### 4. Save to Knowledge Base (if confirmed)

Only save CONFIRMED or PARTIALLY TRUE claims — user doesn't need to remember false info.

**Database location:** `~/.rumor-busted/knowledge.db`

**To save, run:**
```bash
sqlite3 ~/.rumor-busted/knowledge.db "INSERT INTO knowledge (id, claim, verdict, summary, sources, original_link, tags) VALUES (
  '$(uuidgen | tr '[:upper:]' '[:lower:]')',
  'The claim text',
  'confirmed',
  'Summary of findings',
  '[\"https://source1.com\", \"https://source2.com\"]',
  'https://original-link-user-shared.com',
  '[\"tag1\", \"tag2\"]'
);"
```

**After saving, confirm:**
> "Saved to your knowledge base. You now have X verified facts stored."

### 5. Query Knowledge Base

When user asks "what do I know about X" or "show my saved facts":

```bash
sqlite3 ~/.rumor-busted/knowledge.db "SELECT claim, verdict, summary FROM knowledge ORDER BY created_at DESC LIMIT 10;"
```

For search:
```bash
sqlite3 ~/.rumor-busted/knowledge.db "SELECT claim, verdict, summary FROM knowledge WHERE claim LIKE '%search term%' OR summary LIKE '%search term%';"
```

## Database Setup

If database doesn't exist, create it:

```bash
mkdir -p ~/.rumor-busted
sqlite3 ~/.rumor-busted/knowledge.db "CREATE TABLE IF NOT EXISTS knowledge (
  id TEXT PRIMARY KEY,
  claim TEXT NOT NULL,
  verdict TEXT NOT NULL,
  summary TEXT NOT NULL,
  sources TEXT,
  original_link TEXT,
  tags TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);"
```

## Conversation Examples

**User:** "Saw someone say MCP is dead, replaced by skills. True?"

**You:** Research → Check MCP docs, Google A2A announcement, OpenAI announcements → Deliver verdict

---

**User:** "What verified facts do I have saved?"

**You:** Query the database → List recent entries

---

**User:** "https://twitter.com/someone/status/123 — is this legit?"

**You:** Fetch the content → Extract claim → Research → Verdict → Save if true

## Tone

Be direct. Have attitude. You're busting BS, not writing a diplomatic memo.

- ❌ "The claim appears to potentially be somewhat inaccurate..."
- ✅ "Busted. Here's what's actually happening..."
