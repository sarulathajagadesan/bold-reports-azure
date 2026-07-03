-- BOLD_UPGRADE_RERUN_SAFE: true
-- BOLD_UPGRADE_IDEMPOTENT_VALIDATED: true
-- BOLD_UPGRADE_STATEMENT_SEPARATOR: $$

SET @boldid_column_count := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_TenantInactivity'
      AND COLUMN_NAME = 'CreatedDate'
);

SET @boldid_column_valid := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_TenantInactivity'
      AND COLUMN_NAME = 'CreatedDate'
      AND DATA_TYPE = 'timestamp'
      AND IS_NULLABLE = 'NO'
      AND UPPER(COLUMN_DEFAULT) LIKE 'CURRENT_TIMESTAMP%'
);

SET @boldid_sql := IF(
    @boldid_column_count = 0,
    'ALTER TABLE {database_name}.BOLDTC_TenantInactivity ADD COLUMN CreatedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP',
    IF(@boldid_column_valid = 1, 'SELECT 1', 'CALL BOLD_UPGRADE_VALIDATION_FAILED()')
);

PREPARE boldid_stmt FROM @boldid_sql;
EXECUTE boldid_stmt;
DEALLOCATE PREPARE boldid_stmt;
$$

SET @boldid_column_count := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_TenantInactivity'
      AND COLUMN_NAME = 'ModifiedDate'
);

SET @boldid_column_valid := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_TenantInactivity'
      AND COLUMN_NAME = 'ModifiedDate'
      AND DATA_TYPE = 'timestamp'
      AND IS_NULLABLE = 'NO'
      AND UPPER(COLUMN_DEFAULT) LIKE 'CURRENT_TIMESTAMP%'
);

SET @boldid_sql := IF(
    @boldid_column_count = 0,
    'ALTER TABLE {database_name}.BOLDTC_TenantInactivity ADD COLUMN ModifiedDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP',
    IF(@boldid_column_valid = 1, 'SELECT 1', 'CALL BOLD_UPGRADE_VALIDATION_FAILED()')
);

PREPARE boldid_stmt FROM @boldid_sql;
EXECUTE boldid_stmt;
DEALLOCATE PREPARE boldid_stmt;
$$
