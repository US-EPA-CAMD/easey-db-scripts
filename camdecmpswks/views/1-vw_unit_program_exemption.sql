-- View: camdecmpswks.vw_unit_program_exemption

DROP VIEW IF EXISTS camdecmpswks.vw_unit_program_exemption CASCADE;

CREATE OR REPLACE VIEW camdecmpswks.vw_unit_program_exemption
 AS
 SELECT ml.mon_loc_id,
    u.unit_id,
    u.fac_id,
    up.prg_cd,
    up.up_id,
    NULL::text AS upe_id,
    pe.exemption_type_cd AS exempt_type_cd,
    ue.ex_rec_date,
    ue.begin_date,
    ue.end_date
   FROM camd.unit_program up
     JOIN camd.unit u ON u.unit_id = up.unit_id
     JOIN camdecmpswks.monitor_location ml ON u.unit_id = ml.unit_id
     JOIN camdmd.program_exemption pe ON pe.prg_cd::text = up.prg_cd::text
     JOIN camd.unit_exemption ue ON ue.unit_id = up.unit_id AND ue.exemption_type_cd::text = pe.exemption_type_cd::text;
