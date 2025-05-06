ALTER TABLE IF EXISTS camdecmpsmd.mats_averaging_group_code
    ADD CONSTRAINT pk_mats_averaging_group_code PRIMARY KEY (mats_avg_group_cd),
    ADD CONSTRAINT uq_mats_averaging_group_code UNIQUE (mats_avg_group_description);

