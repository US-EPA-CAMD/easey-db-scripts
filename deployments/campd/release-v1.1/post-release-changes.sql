delete from camdecmpsmd.dm_emissions_user_code where dm_emissions_user_cd = 'S3BDF';

ALTER TABLE camdecmpsmd.dm_emissions_user_code
	ALTER COLUMN dm_emissions_user_cd TYPE character varying(25);

insert into camdecmpsmd.dm_emissions_user_code
values
	('S3QTRFILES', 'CAMPD Bulk Data Files by quarter', 1),
	('S3STATEFILES', 'CAMPD Bulk Data Files by state', 1);

DROP VIEW IF EXISTS camddmw.vw_emissions_submissions_progress;
DROP VIEW IF EXISTS camddmw.vw_emissions_submissions_received;
DROP VIEW IF EXISTS camddmw.vw_emissions_submissions_expected;
DROP VIEW IF EXISTS camddmw.vw_emissions_submissions_gdm;

DROP VIEW IF EXISTS camdaux.vw_annual_emissions_bulk_files_per_state_to_generate;
DROP VIEW IF EXISTS camdaux.vw_annual_emissions_bulk_files_per_quarter_to_generate;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_progress;
DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_gdm;

ALTER TABLE camdecmps.dm_emissions
	ALTER COLUMN dm_emissions_id DROP DEFAULT;

ALTER TABLE camdecmps.dm_emissions_user
	ALTER COLUMN dm_emissions_user_id SET DEFAULT uuid_generate_v4(),
	ALTER COLUMN dm_emissions_user_cd TYPE character varying(25);

-- ONLY NEED TO RUN THIS PART IN PROD
TRUNCATE camdecmps.dm_emissions_user;

INSERT INTO camdecmps.dm_emissions_user(
	dm_emissions_user_id, dm_emissions_id, dm_emissions_user_cd, process_date, complete_date, note, note_date
)
select
	uuid_generate_v4(),
	dm_emissions_id,
	'S3QTRFILES',
	'2023-01-18',
	'2023-01-18',
	'All quarterly bulk data files for 1995 Q1 thru 2022 Q3 generated as part of CAMPD 1.1 Release 1/18/2023',
	'2023-01-18'
from camdecmps.dm_emissions
where add_date <= '2023-01-01'
order by add_date desc;

INSERT INTO camdecmps.dm_emissions_user(
	dm_emissions_user_id, dm_emissions_id, dm_emissions_user_cd, process_date, complete_date, note, note_date
)
select
	uuid_generate_v4(),
	dm_emissions_id,
	'S3STATEFILES',
	'2023-01-18',
	'2023-01-18',
	'All state bulk data files for 1995 thru 2021 generated as part of CAMPD 1.1 Release 1/18/2023',
	'2023-01-18'
from camdecmps.dm_emissions
where add_date <= '2023-01-01'
order by add_date desc;
