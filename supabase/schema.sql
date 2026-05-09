-- AMH Roadmap — Supabase schema
-- Run this in the Supabase SQL editor: https://supabase.com/dashboard/project/lkyahautfusinqpqmxbh/sql

-- ── Initiatives ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS initiatives (
  id          text        PRIMARY KEY,
  data        jsonb       NOT NULL DEFAULT '{}',
  updated_at  timestamptz NOT NULL DEFAULT now()
);

-- Index for ordering by start date stored inside the JSONB
CREATE INDEX IF NOT EXISTS initiatives_start_idx ON initiatives ((data->>'start'));

-- ── Config ───────────────────────────────────────────────────────────────
-- Stores app-level config: areas, PMs list, Jira config, etc.
CREATE TABLE IF NOT EXISTS config (
  key         text        PRIMARY KEY,
  value       jsonb       NOT NULL DEFAULT '{}',
  updated_at  timestamptz NOT NULL DEFAULT now()
);

-- ── Realtime ─────────────────────────────────────────────────────────────
-- Enable realtime so the app gets live updates across users
ALTER PUBLICATION supabase_realtime ADD TABLE initiatives;
ALTER PUBLICATION supabase_realtime ADD TABLE config;
