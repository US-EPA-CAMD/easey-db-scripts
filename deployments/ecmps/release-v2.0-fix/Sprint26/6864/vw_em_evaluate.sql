-- View: camdecmpswks.vw_em_evaluate
-- This view currently expects the same results as the camdecmpswks.vw_em_export_and_report view, so to avoid duplication and the chance of errors, it simply selects all columns from that view.
CREATE OR REPLACE VIEW camdecmpswks.vw_em_evaluate AS
SELECT
    *
FROM
    camdecmpswks.vw_em_export_and_report;

