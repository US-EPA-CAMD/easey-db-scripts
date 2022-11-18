SELECT    'Facility name change from '
       || a.old_value
       || ' on '
       || TO_CHAR (alias_date, 'MM/DD/YYYY')
          AS dl_comment,
       a.add_date,
       a.update_date,
       a.userid,
       'ALIAS',
       a.old_value AS old_facility_name,
       NULL AS old_orispl_code,
       a.fac_id,
       b.oris_code AS orispl_code,
       b.state,
       b.facility_name,
       b.facility_name || ' (ORISPL ' || b.oris_code || ')' AS faclist,
       UPPER (b.facility_name) AS upper_fac_name,
       NULL AS unit_id,
       NULL AS unitid
  FROM camd.plant_alias a, camd.plant b
 WHERE a.alias_type = 'NAME' AND a.fac_id = b.fac_id --AND a.show_dm = 1
UNION ALL
SELECT    'Facility ID (ORISPL) change from '
       || a.old_value
       || ' to '
       || b.oris_code
          AS dl_comment,
       a.add_date,
       a.update_date,
       a.userid,
       'ALIAS',
       NULL AS old_facility_name,
       a.old_value AS old_orispl_code,
       a.fac_id,
       b.oris_code AS orispl_code,
       b.state,
       b.facility_name,
       b.facility_name || ' (ORISPL ' || b.oris_code || ')' AS faclist,
       UPPER (b.facility_name) AS upper_fac_name,
       NULL AS unit_id,
       NULL AS unitid
  FROM camd.plant_alias a, camd.plant b
 WHERE a.alias_type = 'ORIS' AND a.fac_id = b.fac_id
UNION ALL
SELECT unit_history_comment AS dl_comment,
       a.add_date,
       a.update_date,
       a.userid,
       'ALIAS',
       NULL AS old_facility_name,
       old_oris_code AS old_orispl_code,
       new_fac_id as fac_id,
       new_oris_code AS orispl_code,
       c.state,
       c.facility_name,
       c.facility_name || ' (ORISPL ' || c.oris_code || ')' AS faclist,
       UPPER (c.facility_name) AS upper_fac_name,
       a.unit_id,
       a.new_unitid as unitid
  FROM camd.vw_unit_history a, camd.plant c
 WHERE unit_history_type_cd = 'ALIAS'
   and c.fac_id = a.new_fac_id
UNION ALL
SELECT REPLACE (
          REPLACE (REPLACE (b.facility_name, ' (' || new_oris_code || ')'),
                   ' Unit ' || new_unitid),
          ' (' || new_unitid || ')')
       || ' (ORISPL '
       || new_oris_code
       || ') Unit '
       || new_unitid
       || ' in '
       || d.state_name
       || ' was previously '
       || REPLACE (
             REPLACE (
                REPLACE (c.facility_name, ' (' || old_oris_code || ')'),
                ' Unit ' || old_unitid),
             ' (' || old_unitid || ')')
       || ' (ORISPL '
       || old_oris_code
       || ') Unit '
       || old_unitid
       || ' in '
       || e.state_name
       || ', and started submitting emissions at the new location in Q'
       || TO_CHAR (effective_date, 'Q')
       || ' '
       || TO_CHAR (effective_date, 'YYYY')
          AS dl_comment,
       a.add_date,
       a.update_date,
       a.userid,
       'ALIAS',
       c.facility_name AS old_facility_name,
       a.old_oris_code AS old_orispl_code,
       a.new_fac_id AS fac_id,
       a.new_oris_code AS orispl_code,
       d.state,
       b.facility_name,
       b.facility_name || ' (ORISPL ' || new_oris_code || ')' AS faclist,
       UPPER (b.facility_name) AS upper_fac_name,
       a.unit_id,
       new_unitid
  FROM camd.vw_unit_history a,
       camd.plant b,
       camd.plant c,
       camdmd.state d,
       camdmd.state e
 WHERE     unit_history_type_cd IN ('LOGICAL', 'PHYSCAL')
       AND b.fac_id = a.new_fac_id
       AND c.fac_id = a.old_fac_id
       AND d.state = b.state
       AND e.state = c.state