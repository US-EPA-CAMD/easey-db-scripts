-- DROP TABLE IF EXISTS camdaux.missing_oris;

CREATE TABLE IF NOT EXISTS camdaux.missing_oris
(
    id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    oris_code numeric NOT NULL,
    CONSTRAINT missing_oris_pkey PRIMARY KEY (id)
);

INSERT INTO camdaux.missing_oris(id, oris_code, state_cd)
VALUES
    ('1', 880056, 'TN'),
	('2', 880022, 'DE'),
	('3', 880026, 'TX'),
	('4', 55195, 'WI'),
	('5', 55209, 'ME'),
	('6', 55140, 'TX'),
	('7', 2387, 'MI'),
	('8', 880032, 'MN'),
	('9', 56186, 'WV'),
	('10', 880035, 'WV'),
	('11', 880081, 'NC'),
	('12', 55848, 'CA'),
	('13', 50232, 'CA'),
	('14', 7923, 'AL'),
	('15', 7911, 'MS'),
	('16', 8058, 'MS'),
	('17', 880027, 'VA'),
	('18', 2783, 'OH'),
	('19', 50468, 'CT'),
	('20', 3355, 'KS'),
	('21', 880034, 'SC'),
	('22', 14013, 'LA'),
	('23', 7996, 'AL'),
	('24', 1700, 'CO'),
	('25', 54001, 'CT'),
	('26', 880069, 'OH'),
	('27', 7864, 'NY'),
	('28', 55180, 'VA'),
	('29', 880046, 'OH'),
	('30', 7840, 'IL'),
	('31', 55461, 'UT'),
	('32', 880002, 'TN');
