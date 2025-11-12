create table authors (
    id serial primary key,
    firstname text not null,
    forename text not null,
    UNIQUE(firstname, forename)
);

create table written_by (
    fk_publication bigint REFERENCES publications(id) ON DELETE CASCADE,
    fk_author bigint REFERENCES authors(id) ON DELETE CASCADE,
    author_role TEXT NOT NULL DEFAULT 'Первый автор',
    PRIMARY KEY (fk_publication, fk_author)
)