-- Table: camdecmpsmd.rca_run_status_code

-- DROP TABLE camdecmpsmd.rca_run_status_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.rca_run_status_code
(
    run_status_code_cd character varying(7) NOT NULL,
    run_status_code_cd_description character varying(1000) NOT NULL,
    CONSTRAINT pk_rca_run_status_code PRIMARY KEY (run_status_code_cd)
);

INSERT INTO camdecmpsmd.rca_run_status_code(rca_run_status_code_cd, rca_run_status_code_cd_description)
VALUES
  ('NOTUSED', 'Run not used to meet RCA criteria'),
  ('RUNUSED', 'Run used to meet RCA criteria')
;
