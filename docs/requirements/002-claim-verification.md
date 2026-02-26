# 002: Claim Verification Workflow

## Overview

How Rumor Busted researches and delivers verdicts. The core of the product.

## Key Principle: Break It Down

Articles aren't "true" or "false" as a whole. They're a mix of:
- Verifiable statements
- Misleading framing
- Opinions
- Outright errors

**We break articles into individual sayings — each thing the article says — and evaluate each one.**

## Workflow

### Step 1: Extract Sayings

When user shares a link:

1. Fetch the content
2. Identify what the article says (each discrete saying)
3. Note which are verifiable vs opinion

**Example:**
> Article: "MCP is dead! OpenAI's new Agents SDK replaces it completely, and Google's A2A protocol is the final nail in the coffin."

**Extracted sayings:**
1. "MCP is deprecated/dead"
2. "OpenAI's Agents SDK replaces MCP"
3. "Google's A2A protocol replaces MCP"

**Noted as opinion:**
- "final nail in the coffin" — dramatic framing, not verifiable

### Step 2: Research Each Saying

For each extracted saying:

- Check **minimum 5 sources**
- Prioritize primary sources:
  1. Official documentation
  2. Company announcements/blogs
  3. GitHub repos / changelogs
  4. Credible tech journalism
  5. Author's own statements (if relevant)

**Capture:**
- What sources say
- Direct quotes where possible
- Conflicting information if found

### Step 3: Verdict Per Saying

For each saying, deliver one of:

| Verdict | Meaning | When to use |
|---------|---------|-------------|
| ✅ **CONFIRMED** | Supported by evidence | Backed by primary sources |
| ❌ **BUSTED** | False or misleading | Contradicted by evidence |
| ⚠️ **PARTIALLY TRUE** | Some truth, missing context | Oversimplified or misleading framing |
| 🤷 **UNVERIFIED** | Can't confirm or deny | Insufficient evidence either way |
| 💭 **OPINION** | Not verifiable | Subjective, no verdict needed |

### Step 4: Synthesize Overall Assessment

After evaluating all sayings:

1. Summarize what's supported, what's false, what's opinion
2. Call out misleading framing if present
3. Give overall assessment of the article's reliability

**Example output:**
```
## Article Breakdown

**Source:** [link to original article]

### Say 1: "MCP is dead"
❌ BUSTED

MCP is actively maintained. Latest schema update: 2025-11-25.
Official docs at modelcontextprotocol.io are current.

**Sources:**
- modelcontextprotocol.io (official docs)
- github.com/modelcontextprotocol (active repo)

---

### Say 2: "OpenAI's Agents SDK replaces MCP"
⚠️ PARTIALLY TRUE

OpenAI released an Agents SDK, but it's their own proprietary
solution. They didn't adopt MCP — they built something different.
MCP is an open standard that continues independently.

**Sources:**
- openai.com/index/new-tools-for-building-agents/
- OpenAI Agents SDK docs

---

### Say 3: "Google's A2A replaces MCP"
❌ BUSTED

Google's own announcement explicitly states A2A "complements"
MCP, not replaces it. They solve different problems:
- MCP = model-to-tool communication
- A2A = agent-to-agent communication

**Sources:**
- developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/

---

## Overall Assessment

**Reliability: Low**

Article contains 1 partially true saying and 2 false sayings.
Framing ("dead", "final nail") is sensationalist and unsupported.
```

## Research Guidelines

### Source Quality

Not all sources are equal:

| Tier | Source Type | Trust Level |
|------|-------------|-------------|
| 1 | Official docs, company blogs, GitHub | High |
| 2 | Credible tech journalism (Verge, Ars, TechCrunch) | Medium-High |
| 3 | Industry analysts, known experts | Medium |
| 4 | Random blogs, social media posts | Low — verify elsewhere |

### Handling Paywalled Content

- Try to access what we can
- Note when content is paywalled
- Look for quotes/summaries from credible sources
- Don't make verdicts based on content we can't see

### Handling Opinion vs Verifiable

- Opinions get marked as 💭 OPINION — no verdict needed
- "X is the best" = opinion
- "X has feature Y" = verifiable saying
- "X is dead" = verifiable saying (check the evidence)

## Tone

Be direct. We're busting BS, not writing a diplomatic memo.

- ❌ "The claim appears to potentially be somewhat inaccurate..."
- ✅ "Busted. Google's own announcement says the opposite."
