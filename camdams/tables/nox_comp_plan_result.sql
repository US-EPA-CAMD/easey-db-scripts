CREATE TABLE IF NOT EXISTS camdams.nox_comp_plan_result
(
    comp_plan_id numeric(38,0) NOT NULL,
    comp_period_id numeric(38,0) NOT NULL,
    plan_heat_input numeric(12,0),
    plan_nox_rate numeric(6,3),
    final_ind numeric(1,0) NOT NULL,
    limit_ver_ind numeric(1,0),
    act_heat_input numeric(12,0),
    act_nox_rate numeric(6,3),
    act_nox_mass numeric(12,2),
    allw_nox_mass numeric(12,2),
    allw_nox_rate numeric(6,3),
    avg_plan_act_nox_rate numeric(6,3),
    avg_plan_allw_nox_rate numeric(6,3),
    excess_nox_mass numeric(12,2),
    penalty_amount numeric(12,2),
    penalty_factor numeric(12,2),
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    userid varchar(160),
    PRIMARY KEY (comp_plan_id, comp_period_id)
);
COMMENT ON TABLE camdams.nox_comp_plan_result
    IS 'ARP NOx compliance plan results data.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.comp_plan_id
    IS 'Identity key for NOx comp plan result table.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.comp_period_id
    IS 'Identity key for compliance period table.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.plan_heat_input
    IS 'Planned heat input for units in an averaging plan that fails compliance.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.plan_nox_rate
    IS 'ACEL data.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.final_ind
    IS 'Indicates if the result is final.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.limit_ver_ind
    IS 'Indicator for the verification of ARP NOx limit data.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.act_heat_input
    IS 'Actual heat input.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.act_nox_rate
    IS 'Actual NOx rate.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.act_nox_mass
    IS 'Actual NOx mass.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.allw_nox_mass
    IS 'Allowable NOx mass for plan.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.allw_nox_rate
    IS 'Allowable NOx rate for plan.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.avg_plan_act_nox_rate
    IS 'Actual NOx rate for averaging plan';
COMMENT ON COLUMN camdams.nox_comp_plan_result.avg_plan_allw_nox_rate
    IS 'Allowable NOx rate for averaging plan.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.excess_nox_mass
    IS 'Excess NOx mass.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.penalty_amount
    IS 'Dollar amount of penalty.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.penalty_factor
    IS 'Multiplication factor for penalty amount. ';
COMMENT ON COLUMN camdams.nox_comp_plan_result.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdams.nox_comp_plan_result.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';