CREATE OR REPLACE FUNCTION add_unique_publication(
    p_title TEXT,
    p_annotation TEXT,
    p_results TEXT,
    p_date DATE,
    p_index_type TEXT,
    p_index_value TEXT
) RETURNS INTEGER AS $$
DECLARE
    v_publication_id INTEGER;
    v_external_index_id INTEGER;
    v_exists BOOLEAN;
BEGIN
    -- Проверяем существование индекса
    SELECT EXISTS (
        SELECT 1 
        FROM indexed_at ia
        JOIN external_indexes ei ON ia.fk_external_index = ei.id
        WHERE ei.index_name = p_index_type AND ia.external_index_value = p_index_value
    ) INTO v_exists;
    
    -- Если индекс уже существует, возвращаем 0
    IF v_exists THEN
        RETURN 0;
    END IF;
    
    -- Получаем ID типа индекса
    SELECT id INTO v_external_index_id 
    FROM external_indexes 
    WHERE index_name = p_index_type;
    
    -- Если тип индекса не существует, можно создать его или вернуть ошибку
    IF v_external_index_id IS NULL THEN
        -- Опционально: создать новый тип индекса
        INSERT INTO external_indexes (index_name) 
        VALUES (p_index_type) 
        RETURNING id INTO v_external_index_id;
    END IF;
    
    -- Добавляем публикацию
    INSERT INTO publications (title, annotation, results, date)
    VALUES (p_title, p_annotation, p_results, p_date)
    RETURNING id INTO v_publication_id;
    
    -- Связываем публикацию с индексом
    INSERT INTO indexed_at (fk_external_index, fk_publication, external_index_value)
    VALUES (v_external_index_id, v_publication_id, p_index_value);
    
    -- Возвращаем ID новой публикации
    RETURN v_publication_id;
END;
$$ LANGUAGE plpgsql;