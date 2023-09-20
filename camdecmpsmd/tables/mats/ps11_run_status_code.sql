-- Table: camdecmpsmd.ps11_run_status_code

-- DROP TABLE camdecmpsmd.ps11_run_status_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.ps11_run_status_code
(
    run_status_code_cd character varying(7) NOT NULL,
    run_status_code_cd_description character varying(1000) NOT NULL,
    CONSTRAINT pk_ps11_run_status_code PRIMARY KEY (run_status_code_cd)
);

INSERT INTO camdecmpsmd.ps11_run_status_code(ps11_run_status_code_cd, ps11_run_status_code_cd_description)
VALUES
  ('NOTUSED', 'Run not used in PS-11 Correlation calculation'),
  ('RUNUSED', 'Run used in PS-11 Correlation calculation')
;
