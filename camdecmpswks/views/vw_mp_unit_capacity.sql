CREATE OR REPLACE VIEW camdecmpswks.vw_mp_unit_capacity (mon_plan_id, unit_id, unit_cap_id, begin_date, end_date, max_hi_capacity, mon_loc_id) AS
SELECT
    mpl.mon_plan_id, uc.unit_id, uc.unit_cap_id, uc.begin_date, uc.end_date, uc.max_hi_capacity, ml.mon_loc_id
    FROM camdecmpswks.unit_capacity AS uc
    INNER JOIN camd.unit AS u
        ON u.unit_id = uc.unit_id
    INNER JOIN camdecmpswks.monitor_location AS ml
        ON ml.unit_id = u.unit_id
    INNER JOIN camdecmpswks.monitor_plan_location AS mpl
        ON ml.mon_loc_id = mpl.mon_loc_id;