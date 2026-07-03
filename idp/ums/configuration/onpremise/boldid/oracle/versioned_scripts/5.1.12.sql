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
    WHERE TABLE_NAME = UPPER('BOLDTC_TenantInactivity')
      AND COLUMN_NAME = UPPER('CreatedDate');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDTC_TenantInactivity ADD CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDTC_TenantInactivity')
          AND COLUMN_NAME = UPPER('CreatedDate')
          AND DATA_TYPE LIKE 'TIMESTAMP%'
          AND NULLABLE = 'N';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDTC_TenantInactivity.CreatedDate exists with an unexpected definition.');
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
    WHERE TABLE_NAME = UPPER('BOLDTC_TenantInactivity')
      AND COLUMN_NAME = UPPER('ModifiedDate');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDTC_TenantInactivity ADD ModifiedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDTC_TenantInactivity')
          AND COLUMN_NAME = UPPER('ModifiedDate')
          AND DATA_TYPE LIKE 'TIMESTAMP%'
          AND NULLABLE = 'N';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDTC_TenantInactivity.ModifiedDate exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$
