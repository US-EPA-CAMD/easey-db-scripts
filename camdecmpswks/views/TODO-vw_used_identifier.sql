CREATE OR REPLACE  VIEW camdecmpswks.vw_used_identifier (mon_loc_id, table_cd, identifier, type_or_parameter_cd, formula_or_basis_cd, oris_code, location_identifier, fac_id) AS
SELECT
    ui.mon_loc_id, ui.table_cd, ui.identifier, ui.type_or_parameter_cd, ui.formula_or_basis_cd, ml.oris_code, ml.location_identifier, ml.fac_id
    FROM camdecmpswks.used_identifier AS ui
    INNER JOIN camdecmpswks.vw_monitor_location AS ml
        ON ui.mon_loc_id = ml.mon_loc_id;