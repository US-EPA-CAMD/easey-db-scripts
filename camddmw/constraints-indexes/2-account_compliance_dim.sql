-- Table: camddmw.account_compliance_dim

-- DROP TABLE camddmw.account_compliance_dim;

CREATE TABLE IF NOT EXISTS camddmw.account_compliance_dim
(
    account_number character varying(12) COLLATE pg_catalog."default" NOT NULL,
    prg_code character varying(8) COLLATE pg_catalog."default" NOT NULL,
    op_year numeric(4,0) NOT NULL,
    units_affected character varying(4000) COLLATE pg_catalog."default",
    allocated numeric(15,3),
    total_held numeric(15,3),
    banked_held numeric(15,3),
    current_held numeric(15,3),
    comp_year_emiss numeric(15,3),
    other_deduct numeric(15,3),
    current_deduct numeric(15,3),
    deduct_1_1 numeric(15,3),
    deduct_2_1 numeric(15,3),
    deduct_286_1 numeric(15,3),
    total_deduct numeric(15,3),
    carried_over numeric(15,3),
    excess_emiss numeric(15,3),
    penalty_amount numeric(15,2),
    penalty_deduct_info character varying(4000) COLLATE pg_catalog."default",
    total_req_deduct numeric(15,3),
    add_date timestamp(0) without time zone,
    userid character varying(160) COLLATE pg_catalog."default",
    data_source character varying(35) COLLATE pg_catalog."default",
    last_update_date timestamp without time zone,
    CONSTRAINT pk_account_compliance_dim PRIMARY KEY (account_number, prg_code, op_year),
    CONSTRAINT account_compliance_dim_fk FOREIGN KEY (account_number, prg_code)
        REFERENCES camddmw.account_fact (account_number, prg_code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);

COMMENT ON TABLE camddmw.account_compliance_dim
    IS 'Annual compliance data for each facility or unit account linked to an allowance based compliance program';

COMMENT ON COLUMN camddmw.account_compliance_dim.account_number
    IS 'Account number';

COMMENT ON COLUMN camddmw.account_compliance_dim.prg_code
    IS 'Program code';

COMMENT ON COLUMN camddmw.account_compliance_dim.op_year
    IS 'Year in which data was collected';

COMMENT ON COLUMN camddmw.account_compliance_dim.units_affected
    IS 'Unit ID or list of associated Unit IDs';

COMMENT ON COLUMN camddmw.account_compliance_dim.allocated
    IS 'Number of allowances allocated for the vintage year';

COMMENT ON COLUMN camddmw.account_compliance_dim.total_held
    IS 'Amount of allowances held in the account for compliance';

COMMENT ON COLUMN camddmw.account_compliance_dim.banked_held
    IS 'Sum of the balance_tot where the compyear_dt > allwyear_dt for the comp year and account number';

COMMENT ON COLUMN camddmw.account_compliance_dim.current_held
    IS 'The balance_tot column where the compyear_dt = allwyear_dt for the account number and compliance year';

COMMENT ON COLUMN camddmw.account_compliance_dim.comp_year_emiss
    IS 'Compliance year emissions ';

COMMENT ON COLUMN camddmw.account_compliance_dim.other_deduct
    IS 'Other deductions';

COMMENT ON COLUMN camddmw.account_compliance_dim.current_deduct
    IS 'Current year deductions';

COMMENT ON COLUMN camddmw.account_compliance_dim.deduct_1_1
    IS 'Banked allowances with a 1 to 1 ratio';

COMMENT ON COLUMN camddmw.account_compliance_dim.deduct_2_1
    IS 'Banked allowances with a 2 to 1 ratio';

COMMENT ON COLUMN camddmw.account_compliance_dim.deduct_286_1
    IS 'Banked allowances with a 2.86 to 1 ratio';

COMMENT ON COLUMN camddmw.account_compliance_dim.total_deduct
    IS 'Sum of allowances deducted';

COMMENT ON COLUMN camddmw.account_compliance_dim.carried_over
    IS 'Allowances carried over';

COMMENT ON COLUMN camddmw.account_compliance_dim.excess_emiss
    IS 'Offset liability or Penalty Deduction';

COMMENT ON COLUMN camddmw.account_compliance_dim.penalty_amount
    IS 'Dollar amount of penalty';

COMMENT ON COLUMN camddmw.account_compliance_dim.penalty_deduct_info
    IS 'Number of allowances and allowance vintage';

COMMENT ON COLUMN camddmw.account_compliance_dim.total_req_deduct
    IS 'Sum of Compliance year emissions + Other deductions';

COMMENT ON COLUMN camddmw.account_compliance_dim.add_date
    IS 'Date on which the record was added';

COMMENT ON COLUMN camddmw.account_compliance_dim.userid
    IS 'Initials of user who last modified data';

COMMENT ON COLUMN camddmw.account_compliance_dim.data_source
    IS 'Source of the data';

COMMENT ON COLUMN camddmw.account_compliance_dim.last_update_date
    IS 'Latest add or update date on source records that are used to populate this record';
