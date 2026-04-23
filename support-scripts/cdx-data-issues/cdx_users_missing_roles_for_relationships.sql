SELECT * FROM (
SELECT sub.*,
       CASE
           WHEN sub.IS_REP = 'Yes' AND CDX_ROLES NOT LIKE '%SPONSOR%'
           THEN
               'Yes'
           ELSE
               'No'
       END
           AS MISSING_SPONSOR_ROLE,
       CASE
           WHEN     (   sub.IS_CBS_SUBMIT_AGENT = 'Yes'
                     OR sub.IS_ECMPS_SUBMIT_AGENT = 'Yes')
                AND NOT (   CDX_ROLES LIKE '%SPONSOR%'
                         OR CDX_ROLES LIKE '%SUBMITTER%')
           THEN
               'Yes'
           ELSE
               'No'
       END
           AS MISSING_SUBMITTER_ROLE,
       CASE
           WHEN sub.IS_ECMPS_PREPARE_AGENT = 'Yes' AND CDX_ROLES IS NULL
           THEN
               'Yes'
           ELSE
               'No'
       END
           AS MISSING_PREPARER_ROLE
  FROM (  SELECT cu.cdx_user_id,
                 cu.ppl_id,
                 cu.primary_email_address,
                 LISTAGG (DISTINCT cr.cdx_role_cd, ', ')
                     WITHIN GROUP (ORDER BY cr.cdx_role_id)
                     AS CDX_ROLES,
                 CASE
                     WHEN EXISTS
                              (SELECT PP.PPL_ID
                                 FROM PLANT_PERSON PP
                                WHERE     PP.END_DATE IS NULL
                                      AND PP.RESPONSIBILITY_ID IN
                                              ('PRM', 'ALT')
                                      AND PP.PPL_ID = CU.PPL_ID)
                     THEN
                         'Yes'
                     ELSE
                         'No'
                 END
                     AS IS_REP,
                 CASE
                     WHEN EXISTS
                              (SELECT RA.PPL_ID
                                 FROM REP_AGENT RA
                                WHERE     RA.END_DATE IS NULL
                                      AND RA.RELATION_TYPE_CD = 'SCBS'
                                      AND RA.AGENT_ID = CU.PPL_ID)
                     THEN
                         'Yes'
                     ELSE
                         'No'
                 END
                     AS IS_CBS_SUBMIT_AGENT,
                 CASE
                     WHEN EXISTS
                              (SELECT RA.PPL_ID
                                 FROM REP_AGENT RA
                                WHERE     RA.END_DATE IS NULL
                                      AND RA.RELATION_TYPE_CD LIKE 'SMP%'
                                      AND RA.AGENT_ID = CU.PPL_ID)
                     THEN
                         'Yes'
                     ELSE
                         'No'
                 END
                     AS IS_ECMPS_SUBMIT_AGENT,
                 CASE
                     WHEN EXISTS
                              (SELECT RA.PPL_ID
                                 FROM REP_AGENT RA
                                WHERE     RA.END_DATE IS NULL
                                      AND RA.RELATION_TYPE_CD = 'RET'
                                      AND RA.AGENT_ID = CU.PPL_ID)
                     THEN
                         'Yes'
                     ELSE
                         'No'
                 END
                     AS IS_ECMPS_PREPARE_AGENT
            FROM cdx_user cu
                 INNER JOIN cdx_user_role cur
                     ON cu.cdx_user_id = cur.cdx_user_id
                 INNER JOIN cdx_role cr ON cur.cdx_role_id = cr.cdx_role_id
        GROUP BY cu.cdx_user_id, cu.ppl_id, cu.primary_email_address) sub)
        WHERE MISSING_SPONSOR_ROLE = 'Yes' or MISSING_SUBMITTER_ROLE = 'Yes' or MISSING_PREPARER_ROLE = 'Yes'
        order by missing_sponsor_role desc, missing_submitter_role desc, missing_preparer_role desc, cdx_user_id;
