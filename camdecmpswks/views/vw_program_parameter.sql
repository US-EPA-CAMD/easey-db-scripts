CREATE OR REPLACE VIEW camdecmpswks.vw_program_parameter AS 
SELECT	pp.prg_param_id ,
		pp.prg_id ,
		pp.parameter_cd ,
		pp.required_ind ,
		pc.os_ind ,
		pp.begin_rpt_period_id ,
		pp.end_rpt_period_id ,
		pp.userid ,
		pp.add_date ,
		pp.update_date 
  FROM	CAMDECMPSAUX.program_parameter pp 
  		JOIN CAMD."program" p on p.prg_id = pp.prg_id 
  		JOIN CAMDMD.program_code pc on pc.prg_cd  = p.prg_cd 