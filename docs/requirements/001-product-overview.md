# 001: Product Overview

## What is Rumor Busted?

A tool that researches tech claims and delivers honest verdicts. When you see something on social media that smells like BS, share it with Rumor Busted. We'll dig in, break it down, and tell you what's actually true.

## Why It Exists

The AI/tech space is drowning in noise:
- Hot takes spread faster than facts
- "X is dead" / "Y replaces Z" posts go viral without evidence
- Articles mix facts with opinions and misleading framing
- People make decisions based on hype, not reality

**Rumor Busted cuts through the BS.**

We don't just label articles "true" or "false" — we break them down into what they say, research each one, and give you an honest assessment. The verified say get saved to your personal knowledge base.

## Core Value Proposition

1. **Research, not regurgitation** — We check primary sources (5 minimum), not just repeat what the article says
2. **Say-level analysis** — Articles aren't "true" or "false" in one piece. We break them into what they say and evaluate each
3. **Honest verdicts** — We show what's supported, what's opinion, and what's misleading
4. **Knowledge building** — Verified say are saved so you can reference them later

## MVP Scope

### In Scope

- User shares a link via WhatsApp
- System breaks article into individual say
- System researches each say (minimum 5 sources)
- System delivers verdict for each say
- Verified say saved to local knowledge base
- User can view saved knowledge

### Out of Scope (MVP)

- Querying/searching knowledge base (just view for now)
- Cloud sync / multi-device
- Mobile app
- Browser extension
- User accounts / auth
- Sharing verdicts publicly

## User Flow (MVP)

```
User sees sketchy article on Twitter
         │
         ▼
Shares link to Rumor Busted (WhatsApp)
         │
         ▼
System extracts say from article
         │
         ▼
For each say:
  - Research (5+ sources)
  - Verdict (confirmed/busted/partial/opinion/unverified)
         │
         ▼
Returns breakdown to user
         │
         ▼
Verified say saved to knowledge base
```

## Success Criteria

- User gets honest, researched verdicts (not just "true/false")
- User builds a personal knowledge base of verified say over time
- User trusts the tool enough to use it regularly

## Origin Story

February 2026: People were posting "MCP is being replaced by skills" across social media.

We did the research:
- MCP is alive and actively maintained
- Google's A2A protocol explicitly says it "complements" MCP
- OpenAI chose their own proprietary approach — that's not MCP dying
- "Skills" is just different terminology in different frameworks

**Verdict: Rumor Busted.**

That's the energy. Research first, verdict second. No diplomatic hedging.
