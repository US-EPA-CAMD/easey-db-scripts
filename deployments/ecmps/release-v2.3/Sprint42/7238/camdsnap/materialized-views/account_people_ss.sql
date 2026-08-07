create materialized view camdsnap.ACCOUNT_PEOPLE_SS 
as 
select  acp.ACCOUNT_PPL_ID,
        acp.ACCOUNT_ID,
        acp.PPL_ID,
        acp.RESPONSIBILITY_ID,
        acp.BEGIN_DATE,
        acp.END_DATE,
        acp.ADD_DATE,
        acp.UPDATE_DATE,
        acp.USERID,
        now() as refresh_time
  from  camdams.ACCOUNT_PERSON acp;


comment on materialized view camdsnap.ACCOUNT_PEOPLE_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_PEOPLE_SS';
