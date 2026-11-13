create materialized view camdsnap.NOX_COMP_PLAN_RESULT_SS
AS 
SELECT  npr.comp_plan_id,
        npr.comp_period_id,
        npr.plan_heat_input,
        npr.plan_nox_rate,
        npr.final_ind,
        npr.limit_ver_ind,
        npr.act_heat_input,
        npr.act_nox_rate,
        npr.act_nox_mass,
        npr.allw_nox_mass,
        npr.allw_nox_rate,
        npr.avg_plan_act_nox_rate,
        npr.avg_plan_allw_nox_rate,
        npr.excess_nox_mass,
        npr.penalty_amount,
        npr.penalty_factor,
        npr.add_date,
        npr.update_date,
        npr.userid,
        now() as refresh_time
  FROM  camdams.NOX_COMP_PLAN_RESULT npr;


comment on materialized view camdsnap.NOX_COMP_PLAN_RESULT_SS is 'snapshot table for snapshot CAMDSNAP.NOX_COMP_PLAN_RESULT_SS';
