ALTER TABLE IF EXISTS camd.unit_op_status
    unit_op_status_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    op_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    ADD CONSTRAINT pk_unit_op_status PRIMARY KEY (unit_op_status_id),
    ADD CONSTRAINT uq_unit_op_status UNIQUE (unit_id, op_status_cd, begin_date),
    ADD CONSTRAINT fk_unit_op_status_operating_status_code FOREIGN KEY (op_status_cd)
        REFERENCES camdmd.operating_status_code (op_status_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_unit_op_status_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_unit_op_status_op_status_cd
    ON camd.unit_op_status USING btree
    (op_status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_unit_op_status_unit_id
    ON camd.unit_op_status USING btree
    (unit_id ASC NULLS LAST);
