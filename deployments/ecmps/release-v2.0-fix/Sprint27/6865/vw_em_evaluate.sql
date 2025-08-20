-- View: camdecmpswks.vw_em_evaluate
-- This view currently expects the same results as the camdecmpswks.vw_em_export_and_report view, so to avoid duplication and the chance of errors, it simply selects all columns from that view.
-- Since the underlying view has changed, this statement should be re-run to keep it up to date.
CREATE OR REPLACE VIEW camdecmpswks.vw_em_evaluate AS
SELECT
    *
FROM
    camdecmpswks.vw_em_export_and_report;

