-- camdecmpswks.unit definition

-- Drop table

-- DROP TABLE camdecmpswks.unit;

CREATE TABLE camdecmpswks.unit (
   unit_id numeric(38) NOT NULL,
   non_load_based_ind numeric(1) DEFAULT 0 NOT NULL,
   userid varchar(160) NOT NULL,
   add_date timestamp NOT NULL,
   update_date timestamp NULL,
   CONSTRAINT pk_unit PRIMARY KEY (unit_id)
);

CREATE INDEX IF NOT EXISTS idx_unit_unit_id
    ON camdecmpswks.unit USING btree
    (unit_id ASC NULLS LAST);

--This is to copy initial data from camd.unit to camdecmpswks.unit

INSERT INTO camdecmpswks.unit (unit_id, non_load_based_ind, userid, add_date, update_date)
SELECT
    unit_id,
    non_load_based_ind,
    userid,
    add_date,
    update_date
FROM camd.unit