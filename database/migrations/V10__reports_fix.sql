ALTER TABLE topic_quarter_reports DROP COLUMN "title";
alter table topic_quarter_reports RENAME COLUMN definition TO period_characterization;