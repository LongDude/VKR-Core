CREATE TABLE openalex_montly_topic_stats (
    id BIGSERIAL PRIMARY KEY,
    topic_id BIGINT REFERENCES topics(id) ON DELETE SET NULL,
    period_start DATE NOT NULL,
    works_count INTEGER NOT NULL,
    collected_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (topic_id, period_start)
);

CREATE INDEX idx_monthly_stats_topic_id ON openalex_montly_topic_stats (topic_id);
