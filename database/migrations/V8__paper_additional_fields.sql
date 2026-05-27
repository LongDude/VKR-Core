-- Позволяет декодировать первичную тему для papers без сортировки подзапроса по M-M таблице
ALTER TABLE papers ADD COLUMN primary_topic_id bigint NULL;
ALTER TABLE papers ADD CONSTRAINT fk_papers_primary_topic FOREIGN KEY (primary_topic_id) REFERENCES topics(id) ON DELETE SET NULL;

-- Извлеченные в HybridRanker ключевые слова. Нужны для вывода и конспектирования области
ALTER TABLE papers ADD COLUMN extracted_keywords jsonb NULL;

