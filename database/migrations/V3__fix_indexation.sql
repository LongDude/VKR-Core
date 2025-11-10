drop table indexed_at;
create table indexed_at (
	fk_publication bigint references publications(id) ON DELETE CASCADE,
	fk_external_index bigint references external_indexes(id) ON DELETE CASCADE,
    external_index_value TEXT NOT NULL,
    PRIMARY KEY (fk_publication, fk_external_index)
);