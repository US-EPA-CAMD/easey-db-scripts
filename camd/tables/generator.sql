CREATE TABLE IF NOT EXISTS camd.generator
(
    gen_id numeric(38,0) NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    genid character varying(8) COLLATE pg_catalog."default" NOT NULL,
    gen_source_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    arp_nameplate_capacity numeric(7,3),
    other_nameplate_capacity numeric(7,3),
    utility_ind numeric(1,0),
    prime_mover_type_cd character varying(7) COLLATE pg_catalog."default",
    gen_capacity_factor numeric(5,3),
    online_year numeric(4,0),
    eia_year numeric(4,0),
    userid character varying(160) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camd.generator
    IS 'Identifies power generator associated with FACILITY.';

COMMENT ON COLUMN camd.generator.gen_id
    IS 'Identity key for GENERATOR table.';

COMMENT ON COLUMN camd.generator.fac_id
    IS 'FACILITY ID identity key.';

COMMENT ON COLUMN camd.generator.genid
    IS 'Public identifier used for GENERATOR as reported to EIA and for New Unit Exemption purposes.';

COMMENT ON COLUMN camd.generator.gen_source_cd
    IS 'Source code of GENERATOR data.';

COMMENT ON COLUMN camd.generator.arp_nameplate_capacity
    IS 'Design nameplate capacity, in megawatts, of the GENERATOR.';

COMMENT ON COLUMN camd.generator.other_nameplate_capacity
    IS 'Nameplate capacity, in megawatts, of the GENERATOR as applicable to other programs such as CAIR.';

COMMENT ON COLUMN camd.generator.utility_ind
    IS 'Identifies whether a GENERATOR is a utility or a non-utility.';

COMMENT ON COLUMN camd.generator.prime_mover_type_cd
    IS 'Type, such as combined cycle, steam turbine, etc., of a GENERATOR.';

COMMENT ON COLUMN camd.generator.gen_capacity_factor
    IS 'Capacity factor based on actual operations.';

COMMENT ON COLUMN camd.generator.online_year
    IS 'Four digit year that the GENERATOR came online.';

COMMENT ON COLUMN camd.generator.eia_year
    IS 'The year for which EIA identification information is provided.';

COMMENT ON COLUMN camd.generator.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.generator.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.generator.update_date
    IS 'Date of the last record update.';
