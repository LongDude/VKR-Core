CREATE OR REPLACE FUNCTION add_author_publication(
    p_firstname TEXT,
    p_forename TEXT,
    p_role TEXT,
    p_publication_id BIGINT
) RETURNS void AS $$
DECLARE 
    v_author_id INTEGER;
BEGIN
    -- Search author if exists --
    SELECT id 
    FROM authors 
    WHERE
        firstname=p_firstname AND
        forename=p_forename
    INTO v_author_id;

    -- Create author if not exists
    IF v_author_id IS NULL 
    THEN
        INSERT INTO authors (firstname, forename) 
        VALUES (p_firstname, p_forename)
        RETURNING id INTO v_author_id;
    END IF;

    INSERT INTO written_by (fk_publication, fk_author, author_role)
    VALUES (p_publication_id, v_author_id, p_role);

END;
$$ LANGUAGE plpgsql;