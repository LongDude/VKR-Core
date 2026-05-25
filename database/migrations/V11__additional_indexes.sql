ALTER TABLE papers
ALTER COLUMN openalex_id SET NOT NULL;
ALTER TABLE papers
ADD CONSTRAINT papers_openalex_id_key UNIQUE (openalex_id);