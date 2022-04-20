-- Table: camdecmps.dm_emissions

-- DROP TABLE camdecmps.dm_emissions;

CREATE TABLE IF NOT EXISTS camdecmps.dm_emissions
(
    dm_emissions_id character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT NULL::character varying,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    apportionment_type_cd character varying(7) COLLATE pg_catalog."default",
    emissions_created_flg character varying(1) COLLATE pg_catalog."default" NOT NULL,
    data_source character varying(35) COLLATE pg_catalog."default" NOT NULL,
    userid character varying(8) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    CONSTRAINT dm_emissions_pk PRIMARY KEY (dm_emissions_id),
    CONSTRAINT dm_emissions_uq UNIQUE (mon_plan_id, rpt_period_id),
    CONSTRAINT dm_emissions_apptype_fk FOREIGN KEY (apportionment_type_cd)
        REFERENCES camdecmpsmd.apportionment_type_code (apportionment_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmps.dm_emissions
    IS 'The parent table for ECMPS D&M Emissions data.  This table has a record for each submitted emission report for a particular monitoring plan and reporting period.  The record indicates the apportionment type of the emissions report and whether all the emissions data was created.';

COMMENT ON COLUMN camdecmps.dm_emissions.dm_emissions_id
    IS 'Primary key.';

COMMENT ON COLUMN camdecmps.dm_emissions.mon_plan_id
    IS 'Foreign key into the MONITOR_PLAN table that uniquely identifies a monitoring plan of the emissions report.';

COMMENT ON COLUMN camdecmps.dm_emissions.rpt_period_id
    IS 'Foreign key into the REPORTING_PERIOD table that uniquely indentifies the reporting period of the emissions report.';

COMMENT ON COLUMN camdecmps.dm_emissions.apportionment_type_cd
    IS 'Code used to indicate the apportionment type of an emissions report.';

COMMENT ON COLUMN camdecmps.dm_emissions.emissions_created_flg
    IS 'Indicates whether all D&M Emissions data exists for this record.';

COMMENT ON COLUMN camdecmps.dm_emissions.data_source
    IS 'Indicates the source ECMPS database of the emissions report.';

COMMENT ON COLUMN camdecmps.dm_emissions.userid
    IS 'The user id of the submitter of the emissions report.';

COMMENT ON COLUMN camdecmps.dm_emissions.add_date
    IS 'The date this record was inserted into the table.';
