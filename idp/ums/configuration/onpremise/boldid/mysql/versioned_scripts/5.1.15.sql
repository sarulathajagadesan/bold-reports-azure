-- BOLD_UPGRADE_RERUN_SAFE: true
-- BOLD_UPGRADE_IDEMPOTENT_VALIDATED: true
-- BOLD_UPGRADE_STATEMENT_SEPARATOR: $$

CREATE TABLE IF NOT EXISTS {database_name}.BOLDTC_UmsConfiguration (
    Id int NOT NULL AUTO_INCREMENT,
    SystemKey nvarchar(255) NOT NULL UNIQUE,
    SystemValue nvarchar(4000),
    ModifiedDate datetime NOT NULL,
    CONSTRAINT PK_BOLDTC_UmsConfiguration PRIMARY KEY (Id)
)
$$

CREATE TABLE IF NOT EXISTS {database_name}.BOLDTC_BiConfiguration (
    Id int NOT NULL AUTO_INCREMENT,
    SystemKey nvarchar(255) NOT NULL UNIQUE,
    SystemValue nvarchar(4000),
    ModifiedDate datetime NOT NULL,
    CONSTRAINT PK_BOLDTC_BiConfiguration PRIMARY KEY (Id)
)
$$

SET @boldid_old_column_count := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_TenantInactivity'
      AND COLUMN_NAME = 'IsRecordsDeletedInMetaTables'
);

SET @boldid_new_column_valid := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_TenantInactivity'
      AND COLUMN_NAME = 'IsImdbTablesDeleted'
      AND COLUMN_TYPE = 'tinyint(1)'
      AND IS_NULLABLE = 'NO'
);

SET @boldid_sql := IF(
    @boldid_old_column_count = 1,
    'ALTER TABLE {database_name}.BOLDTC_TenantInactivity CHANGE COLUMN IsRecordsDeletedInMetaTables IsImdbTablesDeleted tinyint(1) NOT NULL',
    IF(@boldid_new_column_valid = 1, 'SELECT 1', 'CALL BOLD_UPGRADE_VALIDATION_FAILED()')
);

PREPARE boldid_stmt FROM @boldid_sql;
EXECUTE boldid_stmt;
DEALLOCATE PREPARE boldid_stmt;
$$
