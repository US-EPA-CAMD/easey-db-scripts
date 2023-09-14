-- Table: camdecmpsmd.reference_level_code

-- DROP TABLE camdecmpsmd.reference_level_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.reference_level_code
(
    reference_level_cd character varying(7) NOT NULL,
    reference_level_cd_description character varying(1000) NOT NULL,
    CONSTRAINT pk_reference_level_code PRIMARY KEY (reference_level_cd)
);

INSERT INTO camdecmpsmd.reference_level_code(reference_level_cd, reference_level_cd_description)
VALUES
  ('LOW', 'Low Level'),
  ('MID', 'Mid Level'),
  ('HIGH', 'High Level')
;
