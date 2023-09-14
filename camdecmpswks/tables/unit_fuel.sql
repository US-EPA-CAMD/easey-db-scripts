CREATE TABLE IF NOT EXISTS camdecmpswks.unit_fuel
(
    uf_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    fuel_type character varying(7) COLLATE pg_catalog."default" NOT NULL,
    begin_date date NOT NULL,
    end_date date,
    indicator_cd character varying(7) COLLATE pg_catalog."default",
    act_or_proj_cd character varying(7) COLLATE pg_catalog."default",
    ozone_seas_ind numeric(1,0),
    dem_so2 character varying(7) COLLATE pg_catalog."default",
    dem_gcv character varying(7) COLLATE pg_catalog."default",
    sulfur_content numeric(5,4),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone
);
