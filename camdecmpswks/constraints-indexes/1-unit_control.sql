ALTER TABLE IF EXISTS camdecmpswks.unit_control
    ADD CONSTRAINT pk_unit_control PRIMARY KEY (ctl_id),
    ADD CONSTRAINT fk_unit_control_control_code FOREIGN KEY (control_cd)
        REFERENCES camdecmpsmd.control_code (control_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_control_control_equip_param_code FOREIGN KEY (ce_param)
        REFERENCES camdecmpsmd.control_equip_param_code (control_equip_param_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_control_fuel_indicator_code FOREIGN KEY (indicator_cd)
        REFERENCES camdecmpsmd.fuel_indicator_code (fuel_indicator_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_control_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_control_unit_id
    ON camdecmpswks.unit_control USING btree
    (unit_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_control_control_cd
    ON camdecmpswks.unit_control USING btree
    (control_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_control_ce_param
    ON camdecmpswks.unit_control USING btree
    (ce_param COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_control_indicator_cd
    ON camdecmpswks.unit_control USING btree
    (indicator_cd COLLATE pg_catalog."default" ASC NULLS LAST);
