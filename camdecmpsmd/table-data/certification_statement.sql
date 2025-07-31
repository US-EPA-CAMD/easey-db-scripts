-----------------------------------------------------------------------
TRUNCATE camdecmpsmd.certification_statement;
INSERT INTO camdecmpsmd.certification_statement(
  statement_id, prg_cd, statement_location, display_order
) VALUES
  (1,	null, '/certification_statements/submission_cert_statement.general.html', 1),
  (2, 'RGGI', '/certification_statements/submission_cert_statement.rggi.html', 2),
  (3,	'MATS', '/certification_statements/submission_cert_statement.mats.html', 3);
-----------------------------------------------------------------------
