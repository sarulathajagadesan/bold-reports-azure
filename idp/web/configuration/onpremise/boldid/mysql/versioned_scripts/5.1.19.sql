-- BOLD_UPGRADE_RERUN_SAFE: true
-- BOLD_UPGRADE_IDEMPOTENT_VALIDATED: true
-- BOLD_UPGRADE_STATEMENT_SEPARATOR: $$

SET @boldid_column_count := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_Tenant'
      AND COLUMN_NAME = 'ProxyFullPathUrl'
);

SET @boldid_column_valid := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_Tenant'
      AND COLUMN_NAME = 'ProxyFullPathUrl'
      AND DATA_TYPE = 'char'
      AND CHARACTER_MAXIMUM_LENGTH = 255
      AND IS_NULLABLE = 'YES'
);

SET @boldid_sql := IF(
    @boldid_column_count = 0,
    'ALTER TABLE {database_name}.BOLDTC_Tenant ADD ProxyFullPathUrl char(255) NULL',
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
      AND TABLE_NAME = 'BOLDTC_Tenant'
      AND COLUMN_NAME = 'PreventProxyDomainAutoUpdate'
);

SET @boldid_column_valid := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'BOLDTC_Tenant'
      AND COLUMN_NAME = 'PreventProxyDomainAutoUpdate'
      AND COLUMN_TYPE = 'tinyint(1)'
      AND IS_NULLABLE = 'NO'
      AND COLUMN_DEFAULT = '0'
);

SET @boldid_sql := IF(
    @boldid_column_count = 0,
    'ALTER TABLE {database_name}.BOLDTC_Tenant ADD PreventProxyDomainAutoUpdate tinyint(1) NOT NULL DEFAULT 0',
    IF(@boldid_column_valid = 1, 'SELECT 1', 'CALL BOLD_UPGRADE_VALIDATION_FAILED()')
);

PREPARE boldid_stmt FROM @boldid_sql;
EXECUTE boldid_stmt;
DEALLOCATE PREPARE boldid_stmt;
$$
