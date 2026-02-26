#!/bin/bash
# Initialize Rumor Busted knowledge base

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

echo "✅ Knowledge base ready at ~/.rumor-busted/knowledge.db"
