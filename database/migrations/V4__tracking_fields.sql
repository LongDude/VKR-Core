CREATE TABLE user_tracked_fields (
    user_id      BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    field_id  BIGINT NOT NULL REFERENCES fields(id) ON DELETE CASCADE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),

    PRIMARY KEY (user_id, field_id)
);