-- View: camdecmpswks.vw_monitor_location

DROP VIEW IF EXISTS camdecmpswks.vw_monitor_location;

CREATE OR REPLACE VIEW camdecmpswks.vw_monitor_location
 AS
 SELECT ml.mon_loc_id,
    COALESCE(p1.oris_code, p2.oris_code) AS oris_code,
    COALESCE(p1.facility_name, p2.facility_name) AS facility_name,
    COALESCE(sp.stack_name, u.unitid) AS location_identifier,
    COALESCE(p1.fac_id, p2.fac_id) AS fac_id,
    COALESCE(p1.state, p2.state) AS state,
    COALESCE(p1.county_cd, p2.county_cd) AS county_cd,
    u.unit_id,
    sp.stack_pipe_id,
    u.non_load_based_ind,
    sp.active_date,
    sp.retire_date,
    u.unitid,
    sp.stack_name,
    u.comr_op_date,
    u.comm_op_date
   FROM camdecmpswks.monitor_location ml
     LEFT JOIN camd.unit u ON ml.unit_id = u.unit_id
     LEFT JOIN camdecmpswks.stack_pipe sp ON ml.stack_pipe_id::text = sp.stack_pipe_id::text
     LEFT JOIN camd.plant p1 ON u.fac_id = p1.fac_id
     LEFT JOIN camd.plant p2 ON sp.fac_id = p2.fac_id;
