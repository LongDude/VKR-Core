-- database/migrations/V1__initial.sql
CREATE TABLE IF NOT EXISTS schema_version (
    version_rank INTEGER NOT NULL,
    installed_rank INTEGER NOT NULL,
    version VARCHAR(50) PRIMARY KEY,
    description VARCHAR(200) NOT NULL,
    type VARCHAR(20) NOT NULL,
    script VARCHAR(1000) NOT NULL,
    checksum INTEGER,
    installed_by VARCHAR(100) NOT NULL,
    installed_on TIMESTAMP NOT NULL DEFAULT NOW(),
    execution_time INTEGER NOT NULL,
    success BOOLEAN NOT NULL
);