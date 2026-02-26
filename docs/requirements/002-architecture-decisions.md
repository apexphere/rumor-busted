# 002: Architecture Decisions for MVP

## Overview

Technical decisions for Rumor Busted MVP, optimized for speed-to-market while keeping the door open for future evolution.

---

## Decision 1: Knowledge Base Storage

### Options Evaluated

| Option | Pros | Cons |
|--------|------|------|
| **SQLite (local)** | Simple, portable, zero setup | No cloud sync, single device |
| **Turso** | SQLite-compatible, edge-deployed, scales well | Newer, less ecosystem |
| **Supabase** | PostgreSQL, auth built-in, REST API, mobile SDKs, free tier | Heavier than needed for MVP |
| **Markdown files** | Human-readable, git-friendly | Hard to query, no structure |

### Recommendation: Supabase

**Why:**
- Free tier covers MVP
- Auth built-in (needed for "user's knowledge base")
- REST API works with any client (WhatsApp bot today, mobile app later)
- Official SDKs for React Native, Swift, Kotlin (future mobile app)
- PostgreSQL = can add vector search later (for semantic KB queries)

### Swappability Strategy

Use a **Repository Pattern** to abstract storage:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Rumor Busted   │ ──► │  KnowledgeRepo  │ ──► │    Supabase     │
│     Service     │     │   (interface)   │     │   (for now)     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
                                │
                                ▼
                        Future: Turso, SQLite, 
                        Notion API, Obsidian, etc.
```

**Interface:**
```typescript
interface KnowledgeRepository {
  save(userId: string, entry: KnowledgeEntry): Promise<void>
  list(userId: string): Promise<KnowledgeEntry[]>
  get(userId: string, id: string): Promise<KnowledgeEntry | null>
  delete(userId: string, id: string): Promise<void>
  search(userId: string, query: string): Promise<KnowledgeEntry[]>
}
```

Swap storage by implementing a new repository — no service changes needed.

---

## Decision 2: Entry Point / Interface

### Options Evaluated

| Option | Pros | Cons |
|--------|------|------|
| **WhatsApp via OpenClaw** | Zero app install, familiar UX, quick MVP | Limited UI, depends on OpenClaw |
| **Telegram bot** | Easy bot API, rich features | Smaller user base |
| **Web app** | Full control, rich UI | Needs hosting, users must visit |
| **Mobile app** | Best UX, native features | Weeks of dev, app store review |
| **Browser extension** | Context at source (Twitter, etc.) | Limited mobile support |

### Recommendation: WhatsApp via OpenClaw (MVP)

**Why:**
- Users already have WhatsApp
- OpenClaw handles the integration
- Share link → get verdict → done
- No app install friction

### Future Mobile App Strategy

Design **API-first** so mobile app can reuse everything:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│    WhatsApp     │     │                 │     │                 │
│   (OpenClaw)    │ ──► │   Rumor Busted  │ ◄── │   Mobile App    │
│                 │     │      API        │     │    (future)     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
                               │
                               ▼
                        ┌─────────────────┐
                        │   Research +    │
                        │   Knowledge     │
                        │    Services     │
                        └─────────────────┘
```

**API Endpoints (draft):**
```
POST /api/verify          # Submit claim/link for verification
GET  /api/verify/:id      # Check verification status
GET  /api/knowledge       # List user's saved knowledge
DELETE /api/knowledge/:id # Remove entry
```

WhatsApp bot and future mobile app both call the same API.

---

## Decision 3: Tech Stack

| Layer | Choice | Rationale |
|-------|--------|-----------|
| **Runtime** | Node.js | Same as OpenClaw, team familiarity |
| **Framework** | Hono or Express | Lightweight, works anywhere |
| **Database** | Supabase (PostgreSQL) | See Decision 1 |
| **Auth** | Supabase Auth | Comes free with Supabase |
| **Hosting** | Railway or Fly.io | Simple deploys, free tier |
| **Research** | Web fetch + LLM | OpenClaw's existing capabilities |

---

## Summary

| Decision | MVP Choice | Swap Path |
|----------|-----------|-----------|
| Knowledge Base | Supabase | Repository pattern |
| Entry Point | WhatsApp/OpenClaw | API-first design |
| Mobile App | Not in MVP | API ready for it |

---

## Open Questions (Resolved)

| Question | Resolution |
|----------|------------|
| What is the knowledge base? | Supabase with repository abstraction |
| How does user submit? | WhatsApp via OpenClaw |
| Future mobile app? | API-first, ready when needed |
