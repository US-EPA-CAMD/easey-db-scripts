CREATE TABLE IF NOT EXISTS camdaux.bookmark
(
    bookmark_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1000 MINVALUE 1000 MAXVALUE 2147483647 CACHE 1 ),
    bookmark_data text COLLATE pg_catalog."default" NOT NULL,
    bookmark_add_date timestamp without time zone NOT NULL DEFAULT timezone('est'::text, CURRENT_TIMESTAMP),
    bookmark_last_accessed_date timestamp without time zone,
    bookmark_hit_count integer
);