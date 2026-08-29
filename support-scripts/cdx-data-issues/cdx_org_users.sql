  select * from (
  SELECT cui.cdx_org_id,
         cui.cdx_org_name,
         LISTAGG (DISTINCT cui_sp.cdx_user_id, ', ')
             WITHIN GROUP (ORDER BY cui_sp.cdx_user_id)
             AS sponsors,
         LISTAGG (DISTINCT cui_sub.cdx_user_id, ', ')
             WITHIN GROUP (ORDER BY cui_sub.cdx_user_id)
             AS submitters,
         LISTAGG (DISTINCT cui_pre.cdx_user_id, ', ')
             WITHIN GROUP (ORDER BY cui_pre.cdx_user_id)
             AS preparers
    FROM vw_cdx_user_info cui
         LEFT OUTER JOIN vw_cdx_user_info cui_sp
             ON     cui.CDX_ORG_ID = cui_sp.CDX_ORG_ID
                AND cui_sp.CDX_ROLE_DESCRIPTION = 'Sponsor'
         LEFT OUTER JOIN vw_cdx_user_info cui_sub
             ON     cui.CDX_ORG_ID = cui_sub.CDX_ORG_ID
                AND cui_sub.CDX_ROLE_DESCRIPTION = 'Submitter'
         LEFT OUTER JOIN vw_cdx_user_info cui_pre
             ON     cui.CDX_ORG_ID = cui_pre.CDX_ORG_ID
                AND cui_pre.CDX_ROLE_DESCRIPTION = 'Preparer'
   WHERE     cui.CDX_USER_ORG_ACTIVE_IND = 1
         AND cui.CDX_USER_ORG_ROLE_ACTIVE_IND = 1
GROUP BY cui.cdx_org_id, cui.cdx_org_name
ORDER BY cui.cdx_org_name)
where sponsors is null and (submitters is not null or preparers is not null);
 