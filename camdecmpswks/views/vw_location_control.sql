-- View: camdecmpswks.vw_location_control

-- DROP VIEW camdecmpswks.vw_location_control;

CREATE OR REPLACE VIEW camdecmpswks.vw_location_control
 AS
 SELECT uc.ctl_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    uc.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uc.ce_param,
    uc.control_cd,
    cc.control_description AS control_cd_description,
    uc.orig_cd AS orig_ind,
    uc.seas_cd AS seas_ind,
    uc.opt_date,
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
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_stack_configuration usc ON ml.stack_pipe_id::text = usc.stack_pipe_id::text
     JOIN camdecmpswks.unit_control uc ON usc.unit_id = uc.unit_id AND (uc.install_date IS NULL OR usc.end_date IS NULL OR uc.install_date <= usc.end_date) AND (uc.retire_date IS NULL OR uc.retire_date >= usc.begin_date)
     JOIN camd.unit u ON u.unit_id = usc.unit_id
     LEFT JOIN camdecmpsmd.control_code cc ON cc.control_cd::text = uc.control_cd::text AND lower(cc.control_equip_param_cd::text) = lower(uc.ce_param::text)
UNION
 SELECT uc.ctl_id,
    ml.oris_code,
    ml.location_identifier,
    ml.mon_loc_id,
    ml.fac_id,
    uc.unit_id,
    u.unitid,
    u.comm_op_date,
    u.comr_op_date,
    uc.ce_param,
    uc.control_cd,
    cc.control_description AS control_cd_description,
    uc.orig_cd AS orig_ind,
    uc.seas_cd AS seas_ind,
    uc.opt_date,
    uc.install_date,
    uc.retire_date
   FROM camdecmpswks.vw_monitor_location ml
     JOIN camdecmpswks.unit_control uc ON ml.unit_id = uc.unit_id
     JOIN camd.unit u ON u.unit_id = ml.unit_id
     LEFT JOIN camdecmpsmd.control_code cc ON cc.control_cd::text = uc.control_cd::text AND lower(cc.control_equip_param_cd::text) = lower(uc.ce_param::text);
