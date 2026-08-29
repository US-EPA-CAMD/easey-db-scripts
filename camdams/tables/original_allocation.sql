CREATE TABLE IF NOT EXISTS camdams.original_allocation
(
    unit_id numeric(38,0) NOT NULL,
    phase1_allocation numeric(5,0),
    phase1_withholding numeric(5,0),
    phase2a_allocation numeric(5,0),
    phase2a_withholding numeric(5,0),
    phase2b_allocation numeric(5,0),
    phase2b_withholding numeric(5,0),
    optin_allocation1 numeric(5,0),
    optin_allocation2 numeric(5,0),
    exempt_ind numeric(1,0) NOT NULL DEFAULT 0,
    PRIMARY KEY (unit_id)
);
COMMENT ON TABLE camdams.original_allocation
    IS 'Lists historical allocation amounts by phase for unit ids.';
COMMENT ON COLUMN camdams.original_allocation.unit_id
    IS 'Unit ID linked to current record.';
COMMENT ON COLUMN camdams.original_allocation.phase1_allocation
    IS 'Amount of Phase 1 allocation.';
COMMENT ON COLUMN camdams.original_allocation.phase1_withholding
    IS 'Amount of Phase 1 withholding.';
COMMENT ON COLUMN camdams.original_allocation.phase2a_allocation
    IS 'Amount of Phase 2A allocation.';
COMMENT ON COLUMN camdams.original_allocation.phase2a_withholding
    IS 'Amount of Phase 2A withholding.';
COMMENT ON COLUMN camdams.original_allocation.phase2b_allocation
    IS 'Amount of Phase 2B allocation.';
COMMENT ON COLUMN camdams.original_allocation.phase2b_withholding
    IS 'Amount of Phase 2B withholding.';
COMMENT ON COLUMN camdams.original_allocation.optin_allocation1
    IS 'Amount of opt-in allocation.';
COMMENT ON COLUMN camdams.original_allocation.optin_allocation2
    IS 'Amount of opt-in allocation.';
COMMENT ON COLUMN camdams.original_allocation.exempt_ind
    IS 'Indicator of the unit''s exempt status.';