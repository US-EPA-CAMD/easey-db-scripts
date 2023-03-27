-- Table: camdecmpsmd.rra_run_status_code

-- DROP TABLE camdecmpsmd.rra_run_status_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.rra_run_status_code
(
    run_status_code_cd character varying(7) NOT NULL,
    run_status_code_cd_description character varying(1000) NOT NULL,
    CONSTRAINT pk_rra_run_status_code PRIMARY KEY (run_status_code_cd)
);

INSERT INTO camdecmpsmd.rra_run_status_code(rra_run_status_code_cd, rra_run_status_code_cd_description)
VALUES
  ('NOTUSED', 'Run not used to meet RRA criteria'),
  ('RUNUSED', 'Run used to meet RRA criteria')
;
