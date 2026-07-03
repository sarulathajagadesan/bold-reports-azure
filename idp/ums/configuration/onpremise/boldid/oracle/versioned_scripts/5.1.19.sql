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
    WHERE TABLE_NAME = UPPER('BOLDTC_Tenant')
      AND COLUMN_NAME = UPPER('ProxyFullPathUrl');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDTC_Tenant ADD ProxyFullPathUrl NVARCHAR2(255) NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDTC_Tenant')
          AND COLUMN_NAME = UPPER('ProxyFullPathUrl')
          AND DATA_TYPE = 'NVARCHAR2'
          AND CHAR_LENGTH = 255
          AND NULLABLE = 'Y';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDTC_Tenant.ProxyFullPathUrl exists with an unexpected definition.');
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
    WHERE TABLE_NAME = UPPER('BOLDTC_Tenant')
      AND COLUMN_NAME = UPPER('PreventProxyDomainAutoUpdate');

    IF column_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE BOLDTC_Tenant ADD PreventProxyDomainAutoUpdate NUMBER(1) DEFAULT 0 NOT NULL';
    ELSE
        SELECT COUNT(*)
        INTO valid_column_count
        FROM USER_TAB_COLUMNS
        WHERE TABLE_NAME = UPPER('BOLDTC_Tenant')
          AND COLUMN_NAME = UPPER('PreventProxyDomainAutoUpdate')
          AND DATA_TYPE = 'NUMBER'
          AND DATA_PRECISION = 1
          AND DATA_SCALE = 0
          AND NULLABLE = 'N';

        IF valid_column_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'BOLD_UPGRADE_VALIDATION_FAILED: BOLDTC_Tenant.PreventProxyDomainAutoUpdate exists with an unexpected definition.');
        END IF;
    END IF;
END;
$$
