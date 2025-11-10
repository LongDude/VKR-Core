create table publications (
	"id" serial primary key,
	title text not null,
	annotation text,
	summary text,
	results text,
	"year" int4 CHECK ("year" > 0),
	"date" DATE,
	"indexed_at" DATE DEFAULT NOW(),
	complexity_factor FLOAT8 DEFAULT 0,
	volume_factor FLOAT8 DEFAULT 0,
	impact_factor FLOAT8 DEFAULT 0
);


create table external_indexes (
	id serial primary key,
	index_name varchar NOT NULL
);

create table indexed_at (
	id serial primary key,
	fk_publication bigint references publications(id) ON DELETE CASCADE,
	fk_external_index bigint references external_indexes(id) ON DELETE CASCADE
);