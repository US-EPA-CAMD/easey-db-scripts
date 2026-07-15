CREATE TABLE IF NOT EXISTS camdams.nusa_result_unit
(
    nusa_result_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    oris_code numeric(6,0) NOT NULL,
    facility_name varchar(40) NOT NULL,
    unitid varchar(6) NOT NULL,
    eligible_ind numeric(1,0) NOT NULL,
    existing_allocation numeric(15,0),
    first_round_allocation numeric(15,0),
    preliminary_allocation numeric(15,0),
    control_period_emissions numeric(15,1),
    apportioned_ind numeric(1,0),
    adj_control_period_emissions numeric(15,0),
    calculated_maximum numeric(15,0),
    initial_adjusted numeric(15,1),
    secondary_adjusted numeric(15,1),
    submission_id_q1 numeric(38,0),
    submission_id_q2 numeric(38,0),
    submission_id_q3 numeric(38,0),
    submission_id_q4 numeric(38,0),
    emissions_expected_ind numeric(1,0) NOT NULL,
    op_status varchar(7),
    exempt_type varchar(5),
    comr_op_date timestamp without time zone,
    comr_op_date_cd varchar(1),
    unit_monitor_cert_deadline timestamp without time zone,
    unit_monitor_cert_begin_date timestamp without time zone,
    edit_reason clob,
    app_status_pending_ind numeric(1,0) NOT NULL DEFAULT 0,
    effective_comr_op_date timestamp without time zone,
    PRIMARY KEY (nusa_result_id, unit_id)
);
COMMENT ON TABLE camdams.nusa_result_unit
    IS 'Table of result details by unit for the NUSA program.';
COMMENT ON COLUMN camdams.nusa_result_unit.nusa_result_id
    IS 'Identity key for NUSA_RESULT table.';
COMMENT ON COLUMN camdams.nusa_result_unit.unit_id
    IS 'Identity key for UNIT table.';
COMMENT ON COLUMN camdams.nusa_result_unit.oris_code
    IS 'EIA-assigned identifier or FACILITY ID assigned by CAMD (if EIA number is not applicable).';
COMMENT ON COLUMN camdams.nusa_result_unit.facility_name
    IS 'Name of FACILITY.';
COMMENT ON COLUMN camdams.nusa_result_unit.unitid
    IS 'Public identifier used for UNIT for PROGRAM identification purposes.  ';
COMMENT ON COLUMN camdams.nusa_result_unit.eligible_ind
    IS 'Indicates whether unit is eligible for first round NUSA allocation for the selected program and year.';
COMMENT ON COLUMN camdams.nusa_result_unit.existing_allocation
    IS 'Current allocation.';
COMMENT ON COLUMN camdams.nusa_result_unit.first_round_allocation
    IS 'Allocation for the first round when the current allocation is for the second round.';
COMMENT ON COLUMN camdams.nusa_result_unit.preliminary_allocation
    IS 'Allocation for the preliminary run when the current allocation is for the final run.';
COMMENT ON COLUMN camdams.nusa_result_unit.control_period_emissions
    IS 'Emissions value for the control period.';
COMMENT ON COLUMN camdams.nusa_result_unit.apportioned_ind
    IS 'Indicates whether emissions are apportioned for this unit for the selected program and year.';
COMMENT ON COLUMN camdams.nusa_result_unit.adj_control_period_emissions
    IS 'Manually entered Emissions value for the control period.';
COMMENT ON COLUMN camdams.nusa_result_unit.calculated_maximum
    IS 'Maximum allocation that will be made to the unit based on the total emissions that are subject to compliance (prior year emissions for first round or current year emissions for second round).';
COMMENT ON COLUMN camdams.nusa_result_unit.initial_adjusted
    IS 'Maximum allocation times the multiplier.';
COMMENT ON COLUMN camdams.nusa_result_unit.secondary_adjusted
    IS 'The adjustment (if needed) after the initial adjustment is determined.';
COMMENT ON COLUMN camdams.nusa_result_unit.submission_id_q1
    IS 'Unique identifier of a submission.';
COMMENT ON COLUMN camdams.nusa_result_unit.submission_id_q2
    IS 'Unique identifier of a submission.';
COMMENT ON COLUMN camdams.nusa_result_unit.submission_id_q3
    IS 'Unique identifier of a submission.';
COMMENT ON COLUMN camdams.nusa_result_unit.submission_id_q4
    IS 'Unique identifier of a submission.';
COMMENT ON COLUMN camdams.nusa_result_unit.emissions_expected_ind
    IS 'Indicates whether emissions are expected for this unit for the selected program and year.';
COMMENT ON COLUMN camdams.nusa_result_unit.op_status
    IS 'Operating status for a unit.';
COMMENT ON COLUMN camdams.nusa_result_unit.exempt_type
    IS 'Exemption type.';
COMMENT ON COLUMN camdams.nusa_result_unit.comr_op_date
    IS 'First day of commercial operation for a UNIT.';
COMMENT ON COLUMN camdams.nusa_result_unit.comr_op_date_cd
    IS 'Code indicating whether the commercial operation date for a UNIT is projected or actual.';
COMMENT ON COLUMN camdams.nusa_result_unit.unit_monitor_cert_deadline
    IS 'Date by which monitor certification must be completed.';
COMMENT ON COLUMN camdams.nusa_result_unit.unit_monitor_cert_begin_date
    IS 'Date beginning timeline for completion of certification testing.';
COMMENT ON COLUMN camdams.nusa_result_unit.edit_reason
    IS 'Comment for a unit for the selected program and year.';
COMMENT ON COLUMN camdams.nusa_result_unit.app_status_pending_ind
    IS 'Indicates whether unit has a pending applicability determination for the selected program.';
COMMENT ON COLUMN camdams.nusa_result_unit.effective_comr_op_date
    IS 'Effective day of commercial operation for a UNIT.';