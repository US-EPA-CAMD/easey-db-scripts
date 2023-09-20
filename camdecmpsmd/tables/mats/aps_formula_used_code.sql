-- Table: camdecmpsmd.aps_formula_used_code

-- DROP TABLE camdecmpsmd.aps_formula_used_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.aps_formula_used_code
(
    aps_formula_used_cd character varying(7) NOT NULL,
    aps_formula_used_cd_description character varying(1000) NOT NULL,
    CONSTRAINT pk_aps_formula_used_code PRIMARY KEY (aps_formula_used_cd)
);

/***** IS THIS NEEDED OR DO THESE GO IN THE EXISTING APS_CODE TABLE *****/

INSERT INTO camdecmpsmd.aps_formula_used_code(aps_formula_used_cd, aps_formula_used_cd_description)
VALUES
  ('21A', 'APS calculated using Equation 2-1a, procedure 2, or 7.5 percent of the applicable standard'),
  ('21B', 'APS calculated using Equation 2-1b, Procedure 2, or 10 percent of the applicable standard')
;
