CREATE TABLE IF NOT EXISTS camdaux.bookmark
(
    bookmark_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1000 MINVALUE 1000),
    bookmark_data text NOT NULL,
    bookmark_add_date timestamp without time zone NOT NULL DEFAULT timezone('est'::text, CURRENT_TIMESTAMP),
    bookmark_last_accessed_date timestamp without time zone,
	bookmark_hit_count int,
    CONSTRAINT pk_bookmark PRIMARY KEY (bookmark_id)
);