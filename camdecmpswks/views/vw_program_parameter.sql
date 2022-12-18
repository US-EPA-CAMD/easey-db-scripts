-- View: camdecmpswks.vw_program_parameter

DROP VIEW IF EXISTS camdecmpswks.vw_program_parameter;

CREATE OR REPLACE VIEW camdecmpswks.vw_program_parameter
 AS
 SELECT pp.prg_param_id,
    pp.prg_id,
    pp.parameter_cd,
    pp.required_ind,
    pc.os_ind,
    pp.begin_rpt_period_id,
    pp.end_rpt_period_id,
    pp.userid,
    pp.add_date,
    pp.update_date
   FROM camdecmpswksaux.program_parameter pp
     JOIN camd.program p ON p.prg_id = pp.prg_id
     JOIN camdmd.program_code pc ON pc.prg_cd::text = p.prg_cd::text;
