CREATE INDEX IF NOT EXISTS derived_hrly_value_emr_ix 
  ON camdeasey.derived_hrly_value (rpt_period_id,mon_loc_id);
CREATE INDEX IF NOT EXISTS derived_hrly_value_hor_ix 
  ON camdeasey.derived_hrly_value (hour_id);
CREATE INDEX IF NOT EXISTS derived_hrly_value_par_ix 
  ON camdeasey.derived_hrly_value (parameter_cd);
CREATE INDEX IF NOT EXISTS derived_hrly_value_pk 
  ON camdeasey.derived_hrly_value (derv_id);