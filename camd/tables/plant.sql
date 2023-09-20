CREATE TABLE IF NOT EXISTS camd.plant
(
    fac_id numeric(38,0) NOT NULL,
    oris_code numeric(6,0),
    facility_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    description character varying(4000) COLLATE pg_catalog."default",
    state character varying(2) COLLATE pg_catalog."default" NOT NULL,
    county_cd character varying(8) COLLATE pg_catalog."default",
    sic_code numeric(4,0),
    epa_region numeric(2,0),
    nerc_region character varying(5) COLLATE pg_catalog."default",
    airsid character varying(10) COLLATE pg_catalog."default",
    findsid character varying(12) COLLATE pg_catalog."default",
    stateid character varying(15) COLLATE pg_catalog."default",
    latitude numeric(7,4),
    longitude numeric(8,4),
    frs_id character varying(12) COLLATE pg_catalog."default",
    payee_id numeric(6,0),
    permit_exp_date date,
    latlon_source character varying(200) COLLATE pg_catalog."default",
    tribal_land_cd character varying(7) COLLATE pg_catalog."default",
    first_ecmps_rpt_period_id numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);

COMMENT ON TABLE camd.plant
    IS 'Identifies an electric generating or industrial facility consisting of UNITS known to or potentially subject to a trading program.';

COMMENT ON COLUMN camd.plant.fac_id
    IS 'FACILITY ID identity key.';

COMMENT ON COLUMN camd.plant.oris_code
    IS 'EIA-assigned identifier or FACILITY ID assigned by CAMD (if EIA number is not applicable).';

COMMENT ON COLUMN camd.plant.facility_name
    IS 'The name given by the owners and operators to a facility';

COMMENT ON COLUMN camd.plant.description
    IS 'Text description of FACILITY or FACILITY configuration.';

COMMENT ON COLUMN camd.plant.state
    IS 'State abbreviation for which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM, or STAFF is located.';

COMMENT ON COLUMN camd.plant.county_cd
    IS 'Concatenation of State and county code.';

COMMENT ON COLUMN camd.plant.sic_code
    IS 'Standard Industrial Classification System identification number, on a FACILITY basis.   ';

COMMENT ON COLUMN camd.plant.epa_region
    IS 'The EPA Region in which a FACILITY is located.';

COMMENT ON COLUMN camd.plant.nerc_region
    IS 'Code for one of thirteen regions as specified by the  North American Electric Reliability Council.';

COMMENT ON COLUMN camd.plant.airsid
    IS 'The identifier for the FACILITY in the AIRS Facility Subsystem (AFS).';

COMMENT ON COLUMN camd.plant.findsid
    IS 'Cross-reference field for FINDS database.';

COMMENT ON COLUMN camd.plant.stateid
    IS 'The State identification number for a FACILITY or UNIT.';

COMMENT ON COLUMN camd.plant.latitude
    IS 'The latitude at which a FACILITY is located.';

COMMENT ON COLUMN camd.plant.longitude
    IS 'The longitude at which a FACILITY is located.';

COMMENT ON COLUMN camd.plant.frs_id
    IS 'The cross-media Facility Registry System identifier for a FACILITY.';

COMMENT ON COLUMN camd.plant.payee_id
    IS 'ID of a payee entity.';

COMMENT ON COLUMN camd.plant.permit_exp_date
    IS 'Date permit expires.';

COMMENT ON COLUMN camd.plant.latlon_source
    IS 'Source of latitude/longitude data.';

COMMENT ON COLUMN camd.plant.tribal_land_cd
    IS 'Tribal Land abbreviation for tribal land in which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM or STAFF is located.';

COMMENT ON COLUMN camd.plant.first_ecmps_rpt_period_id
    IS 'Identity key from REPORTING_PERIOD for the first quarter a facility reports via ECMPS.';

COMMENT ON COLUMN camd.plant.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.plant.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.plant.update_date
    IS 'Date of the last record update.';
