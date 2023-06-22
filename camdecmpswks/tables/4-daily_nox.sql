CREATE TABLE IF NOT EXISTS camdecmps.daily_nox(
    daily_nox_id character varying(45) NOT NULL,
    daily_emission_id character varying(45) NOT NULL,
	"date" date,
	emissions numeric(x,1),
	heat_input numeric(x,y),
	average_rate numeric(x,3),
	exceedence numeric(x,y),
	cumulative_exceedence numeric(x,y),
    userid character varying(25) NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) NOT NULL,
    CONSTRAINT pk_daily_nox PRIMARY KEY (daily_nox_id),
    CONSTRAINT fk_daily_nox_daily_emission FOREIGN KEY (daily_emission_id)
        REFERENCES camdecmpswks.daily_emission (daily_emission_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_nox_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_nox_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
);

CREATE TABLE IF NOT EXISTS camdecmpswks.daily_nox(
    daily_nox_id character varying(45) NOT NULL,
    daily_emission_id character varying(45) NOT NULL,
	"date" date,
	emissions numeric(x,1),
	heat_input numeric(x,y),
	average_rate numeric(x,3),
	exceedence numeric(x,y),
	cumulative_exceedence numeric(x,y),
    userid character varying(25) NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) NOT NULL,
    CONSTRAINT pk_daily_nox PRIMARY KEY (daily_nox_id),
    CONSTRAINT fk_daily_nox_daily_emission FOREIGN KEY (daily_emission_id)
        REFERENCES camdecmpswks.daily_emission (daily_emission_id) MATCH SIMPLE
		ON DELETE CASCADE,
    CONSTRAINT fk_daily_nox_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_nox_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
);