CREATE INDEX IF NOT EXISTS operating_supp_data_emr_ix 
  ON camdeasey.operating_supp_data (rpt_period_id,mon_loc_id);
CREATE INDEX IF NOT EXISTS operating_supp_data_fue_ix 
  ON camdeasey.operating_supp_data (fuel_cd);
CREATE INDEX IF NOT EXISTS operating_supp_data_loc_ix 
  ON camdeasey.operating_supp_data (mon_loc_id);
CREATE INDEX IF NOT EXISTS operating_supp_data_prd_ix 
  ON camdeasey.operating_supp_data (rpt_period_id);
CREATE INDEX IF NOT EXISTS operating_supp_data_typ_ix 
  ON camdeasey.operating_supp_data (op_type_cd);
CREATE UNIQUE INDEX IF NOT EXISTS pk_operating_supp_data 
  ON camdeasey.operating_supp_data (op_supp_data_id);