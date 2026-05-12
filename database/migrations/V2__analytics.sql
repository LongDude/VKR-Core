CREATE TABLE paper_processing_states (
    paper_id BIGINT PRIMARY KEY REFERENCES papers(id) ON DELETE CASCADE,

    text_hash TEXT,
    embedding_status TEXT NOT NULL DEFAULT 'pending',
    embedding_error TEXT,

    qdrant_indexed_at TIMESTAMPTZ,
    last_processed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE research_clusters (
    id BIGSERIAL PRIMARY KEY,

    cluster_key TEXT NOT NULL UNIQUE,
    cluster_type TEXT NOT NULL,

    source_topic_id BIGINT REFERENCES topics(id) ON DELETE SET NULL,

    name TEXT NOT NULL,
    summary TEXT,

    status TEXT,
    trend_score NUMERIC(8, 5),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE research_cluster_period_stats (
    id BIGSERIAL PRIMARY KEY,

    cluster_id BIGINT NOT NULL REFERENCES research_clusters(id) ON DELETE CASCADE,

    period_start DATE NOT NULL,
    period_end DATE NOT NULL,

    paper_count INTEGER NOT NULL DEFAULT 0,
    previous_paper_count INTEGER NOT NULL DEFAULT 0,

    growth_rate NUMERIC(10, 5),
    trend_score NUMERIC(10, 5),
    semantic_drift NUMERIC(10, 5),

    citation_count_sum INTEGER DEFAULT 0,
    avg_cited_by_count NUMERIC(10, 3),

    top_keywords JSONB,
    representative_paper_ids JSONB,

    summary TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    UNIQUE (cluster_id, period_start, period_end)
);