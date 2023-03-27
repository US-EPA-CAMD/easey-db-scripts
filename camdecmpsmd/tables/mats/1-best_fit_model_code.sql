-- Table: camdecmpsmd.best_fit_model

-- DROP TABLE camdecmpsmd.best_fit_model;

CREATE TABLE IF NOT EXISTS camdecmpsmd.best_fit_model
(
    best_fit_model_cd character varying(7) NOT NULL,
    best_fit_model_cd_description character varying(1000) NOT NULL,
    CONSTRAINT pk_best_fit_model PRIMARY KEY (best_fit_model_cd)
);

INSERT INTO camdecmpsmd.best_fit_model(best_fit_model_cd, best_fit_model_cd_description)
VALUES
  ('LINEAR', 'First-order mathematical relationship between your PM CEMS output and the reference method PM concentration that is linear in form (PS-11, Eq. 11-3)'),
  ('POLYNOM', 'A second-order equation used to define the relationship between your PM CEMS output and reference method PM concentration (PS-11, Eq. 11-16)'),
  ('LOG', 'First-order mathematical relationship between the natural logarithm of your PM CEMS output and the reference method PM concentration that is linear in form (PS-11, Eq. 11-34)'),
  ('EXP', 'An exponential equation used to define the relationship between your PM CEMS output and the reference method PM concentration (PS-11, Eq. 11-37)'),
  ('POWER', 'A power function relationship between your PM CEMS output and the reference method concentration (PS-11, Eq. 11-46)');
