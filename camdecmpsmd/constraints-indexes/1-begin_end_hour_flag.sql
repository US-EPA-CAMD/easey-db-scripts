ALTER TABLE IF EXISTS camdecmpsmd.begin_end_hour_flag
    ADD CONSTRAINT pk_begin_end_hour_flag PRIMARY KEY (begin_end_hour_flg),
    ADD CONSTRAINT uq_begin_end_hour_flag_description UNIQUE (begin_end_hour_description);
