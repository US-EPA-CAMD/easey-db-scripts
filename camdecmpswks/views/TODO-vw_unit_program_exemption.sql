CREATE OR REPLACE  VIEW camdecmpswks.vw_unit_program_exemption (mon_loc_id, unit_id, fac_id, prg_cd, up_id, upe_id, exempt_type_cd, ex_rec_date, begin_date, end_date) AS
SELECT
    ml.mon_loc_id, u.unit_id, u.fac_id, up.prg_cd, up.up_id, upe.upe_id, upe.exempt_type_cd, upe.ex_rec_date, upe.begin_date, upe.end_date
    FROM camd.unit AS u
    INNER JOIN camd.unit_program AS up
        ON u.unit_id = up.unit_id
    INNER JOIN camd.unit_program_exemption AS upe
        ON up.up_id = upe.up_id
    INNER JOIN camdecmpswks.vw_monitor_location AS ml
        ON u.unit_id = ml.unit_id;