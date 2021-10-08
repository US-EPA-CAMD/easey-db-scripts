CREATE TABLE camddmw.unit_compliance_dim
(
    unit_id double precision NOT NULL,
    op_year numeric(4,0) NOT NULL,
    opr_display character varying(1200) COLLATE pg_catalog."default",
    comp_plan_type_cd character varying(1000) COLLATE pg_catalog."default",
    avg_plan_id double precision,
    in_compliance character varying(3) COLLATE pg_catalog."default",
    emiss_limit numeric(6,3),
    act_emiss_rate numeric(6,3),
    avg_plan_emiss_limit numeric(6,3),
    avg_plan_act_emiss_rate numeric(6,3),
    penalty_amount numeric(15,2),
    add_date date,
    userid character varying(8) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    emiss_limit_display numeric(6,3),
    excess_emiss numeric(15,0),
    CONSTRAINT pk_unit_compliance_dim PRIMARY KEY (unit_id, op_year)
);

COMMENT ON TABLE camddmw.unit_compliance_dim
    IS 'ARP NOx Compliance Data from 1997 onward';

COMMENT ON COLUMN camddmw.unit_compliance_dim.unit_id
    IS 'Unique identifier of a unit';

COMMENT ON COLUMN camddmw.unit_compliance_dim.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.unit_compliance_dim.opr_display
    IS 'Formatted list of owners/operators from OWNER_YEAR_DIM.OWN_DISPLAY';

COMMENT ON COLUMN camddmw.unit_compliance_dim.comp_plan_type_cd
    IS 'Value from NOX_COMP_PLAN.COMP_PLAN_TYPE_CD';

COMMENT ON COLUMN camddmw.unit_compliance_dim.avg_plan_id
    IS 'Value from NOX_UNIT_AVG_PLAN.AVG_PLAN_ID';

COMMENT ON COLUMN camddmw.unit_compliance_dim.in_compliance
    IS 'Yes if NOX_COMP_PLAN_RESULT.EXCESS_NOX_MASS has a non-null value greater than zero';

COMMENT ON COLUMN camddmw.unit_compliance_dim.emiss_limit
    IS 'Value from NOX_COMP_PLAN_RESULT.ALLW_NOX_RATE';

COMMENT ON COLUMN camddmw.unit_compliance_dim.act_emiss_rate
    IS 'Value from NOX_COMP_PLAN_RESULT.ACT_NOX_RATE';

COMMENT ON COLUMN camddmw.unit_compliance_dim.avg_plan_emiss_limit
    IS 'Value from NOX_COMP_PLAN_RESULT.AVG_PLAN_ALLW_NOX_RATE';

COMMENT ON COLUMN camddmw.unit_compliance_dim.avg_plan_act_emiss_rate
    IS 'Value from NOX_COMP_PLAN_RESULT.AVG_PLAN_ACT_NOX_RATE';

COMMENT ON COLUMN camddmw.unit_compliance_dim.penalty_amount
    IS 'Dollar amount of penalty';

COMMENT ON COLUMN camddmw.unit_compliance_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.unit_compliance_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.unit_compliance_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.unit_compliance_dim.emiss_limit_display
    IS 'Emissions Limit based on compliance plan.';

COMMENT ON COLUMN camddmw.unit_compliance_dim.excess_emiss
    IS 'Offset liability or Penalty Deduction';