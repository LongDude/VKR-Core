ALTER table publications ADD COLUMN
    pages_count integer not null default 0 check (pages_count >= 0);
