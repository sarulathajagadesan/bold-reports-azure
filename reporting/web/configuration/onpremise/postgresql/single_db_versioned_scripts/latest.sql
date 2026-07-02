CREATE TABLE BOLDRS_ItemSettings(
	Id SERIAL primary key NOT NULL,
	ItemId uuid NOT NULL,
	ItemConfig varchar(4000) NULL,
	ModifiedDate timestamp NOT NULL,
	IsActive smallint NOT NULL)
;

ALTER TABLE BOLDRS_ItemSettings ADD CONSTRAINT FK_ItemSettings_ItemId FOREIGN KEY(ItemId) REFERENCES BOLDRS_Item (Id)
;
CREATE TABLE BOLDRS_CustomEmailTemplate (
    Id SERIAL PRIMARY KEY,
	SiteId uuid NOT NULL,
    IsEnabled smallint,
    DisclaimerContent VARCHAR(255) NOT NULL,
    HeaderContent VARCHAR(255) NULL,
    Subject VARCHAR(255),
    TemplateName VARCHAR(255),
    MailBody TEXT NOT NULL,
    CreatedDate TIMESTAMP NOT NULL,
    ModifiedDate TIMESTAMP,
	SendEmailAsHTML smallint NOT NULL,
	CustomVisibilityOptions TEXT NOT NULL,
    IsActive smallint NOT NULL,
	TemplateId INTEGER NOT NULL,
	IsDefaultTemplate smallint NOT NULL,
	IsSystemDefault smallint NOT NULL,
	Description VARCHAR(255) NULL,
	ModifiedBy int NULL
);

ALTER TABLE BOLDRS_ScheduleDetail ALTER COLUMN ScheduleBucketExportInfo  TYPE TEXT
;
ALTER TABLE boldrs_scheduleparameter ALTER COLUMN parameter TYPE TEXT
;

ALTER TABLE BOLDRS_ScheduleDetail ADD COLUMN IsGroupingEnabled SMALLINT NOT NULL DEFAULT 0;

ALTER TABLE BOLDRS_SubscribedUser ADD COLUMN IsCC SMALLINT NOT NULL DEFAULT 0;

ALTER TABLE BOLDRS_SubscribedGroup ADD COLUMN IsCC SMALLINT NOT NULL DEFAULT 0;

ALTER TABLE BOLDRS_SubscrExtnRecpt ADD COLUMN IsCC SMALLINT NOT NULL DEFAULT 0;

ALTER TABLE BOLDRS_ScheduleDetail ADD COLUMN ExportTypes varchar(500) NULL;
ALTER TABLE BOLDRS_ScheduleDetail ADD COLUMN DataDrivenScheduleDetails  varchar(4000)  NULL;
ALTER TABLE BOLDRS_ScheduleDetail ADD COLUMN IsDataDrivenSchedule smallint NOT NULL DEFAULT 0;
ALTER TABLE BOLDRS_Schedulelog ADD COLUMN RowDetails  varchar(10000)  NULL;
ALTER TABLE BOLDRS_Schedulelog ADD COLUMN IsDataDriven smallint NOT NULL DEFAULT 0;