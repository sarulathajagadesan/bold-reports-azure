-- BOLD_UPGRADE_RERUN_SAFE: true
-- BOLD_UPGRADE_IDEMPOTENT_VALIDATED: true
-- BOLD_UPGRADE_STATEMENT_SEPARATOR: $$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDTC_TenantInfo')
      AND COLUMN_NAME = UPPER('IsRowLevelSecurityEnabled');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDTC_TenantInfo ADD IsRowLevelSecurityEnabled NUMBER(1) DEFAULT 1 NOT NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDTC_TenantInfo')
          AND COLUMN_NAME = UPPER('IsRowLevelSecurityEnabled')
          AND DATA_TYPE = 'NUMBER'
          AND DATA_PRECISION = 1
          AND DATA_SCALE = 0
          AND NULLABLE = 'N';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDTC_TenantInfo.IsRowLevelSecurityEnabled exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$

DECLARE
    column_count NUMBER;
    valid_column_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO column_count
    FROM USER_TAB_COLUMNS
    WHERE TABLE_NAME = UPPER('BOLDTC_AuthSettings')
      AND COLUMN_NAME = UPPER('EncryptionValues');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDTC_AuthSettings ADD EncryptionValues NCLOB';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDTC_AuthSettings')
          AND COLUMN_NAME = UPPER('EncryptionValues')
          AND DATA_TYPE = 'NCLOB'
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDTC_AuthSettings.EncryptionValues exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$
