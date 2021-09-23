CREATE OR REPLACE  VIEW camdecmpswks.vw_location_control (ctl_id, oris_code, location_identifier, mon_loc_id, fac_id, unit_id, unitid, comm_op_date, comr_op_date, ce_param, control_cd, control_cd_description, orig_ind, seas_ind, opt_date, install_date, retire_date) AS
SELECT
    uc.ctl_id, ml.oris_code, ml.location_identifier, ml.mon_loc_id, ml.fac_id, uc.unit_id, u.unitid, u.comm_op_date, u.comr_op_date, uc.ce_param, uc.control_cd, cc.control_cd_description, uc.orig_ind, uc.seas_ind, uc.opt_date,
    CASE
        WHEN usc.begin_date IS NULL THEN uc.install_date
        WHEN uc.install_date IS NULL THEN usc.begin_date
        WHEN uc.install_date >= usc.begin_date THEN uc.install_date
        ELSE usc.begin_date
    END AS install_date,
    CASE
        WHEN usc.end_date IS NULL THEN uc.retire_date
        WHEN uc.retire_date IS NULL THEN usc.end_date
        WHEN uc.retire_date <= usc.end_date THEN uc.retire_date
        ELSE usc.end_date
    END AS retire_date
    FROM camdecmpswks.vw_monitor_location AS ml
    INNER JOIN camdecmpswks.unit_stack_configuration AS usc
        ON ml.stack_pipe_id = usc.stack_pipe_id
    INNER JOIN camdecmpswks.unit_control AS uc
        ON usc.unit_id = uc.unit_id AND (install_date IS NULL OR usc.end_date IS NULL OR install_date <= usc.end_date) AND (uc.retire_date IS NULL OR uc.retire_date >= usc.begin_date)
    INNER JOIN camd.unit AS u
        ON u.unit_id = usc.unit_id
    LEFT OUTER JOIN camdecmpsmd.control_code AS cc
        ON cc.control_cd = uc.control_cd AND LOWER(cc.ce_param) = LOWER(uc.ce_param)
UNION
SELECT
    uc.ctl_id, ml.oris_code, ml.location_identifier, ml.mon_loc_id, ml.fac_id, uc.unit_id, u.unitid, u.comm_op_date, u.comr_op_date, uc.ce_param, uc.control_cd, cc.control_cd_description, uc.orig_ind, uc.seas_ind, uc.opt_date, uc.install_date, uc.retire_date
    FROM camdecmpswks.vw_monitor_location AS ml
    INNER JOIN camdecmpswks.unit_control AS uc
        ON ml.unit_id = uc.unit_id
    INNER JOIN camd.unit AS u
        ON u.unit_id = ml.unit_id
    LEFT OUTER JOIN camdecmpsmd.control_code AS cc
        ON cc.control_cd = uc.control_cd AND LOWER(cc.ce_param) = LOWER(uc.ce_param);