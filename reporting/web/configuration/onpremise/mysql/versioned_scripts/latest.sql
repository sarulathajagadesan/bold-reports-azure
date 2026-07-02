CREATE TABLE {database_name}.BOLDRS_ItemSettings(
	Id int NOT NULL AUTO_INCREMENT,
	ItemId Char(38) NOT NULL,
	ItemConfig varchar(4000) NULL,
	ModifiedDate datetime NOT NULL,
	IsActive tinyint NOT NULL,
	PRIMARY KEY (Id)) ROW_FORMAT=DYNAMIC
;

ALTER TABLE {database_name}.BOLDRS_ItemSettings ADD CONSTRAINT FK_ItemSettings_ItemId FOREIGN KEY(ItemId) REFERENCES {database_name}.BOLDRS_Item (Id)
;
CREATE TABLE {database_name}.BOLDRS_CustomEmailTemplate (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    IsEnabled BIT,
    DisclaimerContent VARCHAR(255) NOT NULL,
    HeaderContent VARCHAR(255) NULL,
    Subject VARCHAR(255),
    TemplateName VARCHAR(255),
    MailBody TEXT NOT NULL,
    CreatedDate DATETIME NOT NULL,
    ModifiedDate DATETIME,
    SendEmailAsHTML BIT NOT NULL,
    CustomVisibilityOptions TEXT NOT NULL,
    IsActive BIT NOT NULL,
	TemplateId INT NOT NULL,
	IsDefaultTemplate BIT NOT NULL,
	IsSystemDefault BIT NOT NULL,
	Description VARCHAR(255) NULL,
	ModifiedBy int NOT NULL
    );
ALTER TABLE {database_name}.BOLDRS_ScheduleDetail ADD COLUMN IsGroupingEnabled  tinyint NOT NULL DEFAULT 0 
;
ALTER TABLE {database_name}.BOLDRS_SubscribedUser ADD COLUMN IsCC  tinyint NOT NULL DEFAULT 0
;
ALTER TABLE {database_name}.BOLDRS_SubscribedGroup ADD COLUMN IsCC  tinyint NOT NULL DEFAULT 0
;
ALTER TABLE {database_name}.BOLDRS_SubscrExtnRecpt ADD COLUMN IsCC  tinyint NOT NULL DEFAULT 0
;
ALTER TABLE {database_name}.BOLDRS_ScheduleDetail ADD COLUMN ExportTypes VARCHAR(500) NULL
;
ALTER TABLE {database_name}.BOLDRS_ScheduleDetail ADD COLUMN DataDrivenScheduleDetails  varchar(4000)  NULL;
ALTER TABLE {database_name}.BOLDRS_ScheduleDetail ADD COLUMN IsDataDrivenSchedule tinyint NOT NULL DEFAULT 0;
ALTER TABLE {database_name}.BOLDRS_Schedulelog ADD COLUMN RowDetails  varchar(10000)  NULL;
ALTER TABLE {database_name}.BOLDRS_Schedulelog ADD COLUMN IsDataDriven smallint NOT NULL DEFAULT 0;
ALTER TABLE {database_name}.BOLDRS_ScheduleLog ADD ExportFileName varchar(255) NULL;
ALTER TABLE {database_name}.BOLDRS_ScheduleLog ADD IsFileActive TINYINT(1) NOT NULL DEFAULT 0;