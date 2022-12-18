-- View: camddmw.vw_rep_display_fact

DROP VIEW IF EXISTS camddmw.vw_rep_display_fact;

CREATE OR REPLACE VIEW camddmw.vw_rep_display_fact
 AS
 SELECT d.unit_id,
    d.op_year,
    string_agg(d.rep_info, ', '::text) AS primary_rep_info
   FROM ( SELECT rep_year_dim.unit_id,
            rep_year_dim.op_year,
                CASE
                    WHEN rep_year_dim.op_year::double precision = date_part('year'::text, rep_year_dim.begin_date) AND rep_year_dim.op_year::double precision = date_part('year'::text, rep_year_dim.end_date) THEN ((((rep_year_dim.ppl_id::text || ' (Started '::text) || to_char(rep_year_dim.begin_date, 'Mon dd, YYYY'::text)) || ')(Ended '::text) || to_char(rep_year_dim.end_date, 'Mon dd, YYYY'::text)) || ')'::text
                    WHEN rep_year_dim.op_year::double precision = date_part('year'::text, rep_year_dim.end_date) THEN ((rep_year_dim.ppl_id::text || ' (Ended '::text) || to_char(rep_year_dim.end_date, 'Mon dd, YYYY'::text)) || ')'::text
                    WHEN rep_year_dim.op_year::double precision = date_part('year'::text, rep_year_dim.begin_date) THEN ((rep_year_dim.ppl_id::text || ' (Started '::text) || to_char(rep_year_dim.begin_date, 'Mon dd, YYYY'::text)) || ')'::text
                    WHEN rep_year_dim.ppl_id IS NULL THEN NULL::text
                    ELSE rep_year_dim.ppl_id::text
                END AS rep_info,
            row_number() OVER (PARTITION BY rep_year_dim.unit_id, rep_year_dim.op_year, rep_year_dim.ppl_id ORDER BY rep_year_dim.unit_id, rep_year_dim.op_year, rep_year_dim.begin_date) AS row_num
           FROM camddmw.rep_year_dim
          WHERE rep_year_dim.rep_code::text = 'PRM'::text OR rep_year_dim.rep_code::text IS NULL
          GROUP BY rep_year_dim.unit_id, rep_year_dim.op_year, rep_year_dim.ppl_id, rep_year_dim.begin_date, rep_year_dim.end_date
          ORDER BY rep_year_dim.unit_id, rep_year_dim.op_year, rep_year_dim.begin_date, (row_number() OVER (PARTITION BY rep_year_dim.unit_id, rep_year_dim.op_year, rep_year_dim.ppl_id ORDER BY rep_year_dim.unit_id, rep_year_dim.op_year, rep_year_dim.begin_date))) d
  WHERE d.row_num = 1
  GROUP BY d.unit_id, d.op_year;
