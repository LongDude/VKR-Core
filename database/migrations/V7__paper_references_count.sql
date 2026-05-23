ALTER TABLE papers ADD COLUMN openalex_id TEXT DEFAULT NULL;
ALTER TABLE papers ADD COLUMN references_count INTEGER DEFAULT 0;
ALTER TABLE papers DROP COLUMN "type";
ALTER TABLE papers DROP COLUMN "created_by_user_id";
ALTER TABLE papers ADD COLUMN text_hash TEXT DEFAULT NULL;
ALTER TABLE papers ADD COLUMN is_indexed BOOLEAN default false NOT NULL;
ALTER TABLE papers ADD COLUMN updated_at TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE papers ADD COLUMN indexed_at TIMESTAMPTZ NOT NULL DEFAULT now();

DROP TABLE paper_processing_states;
DROP TABLE paper_meta_sources;
DROP TABLE meta_sources;