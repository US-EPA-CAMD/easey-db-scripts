create materialized view camdsnap.ACCOUNT_FACILITY_SS 
as 
select  acf.ACCOUNT_ID,
        acf.FAC_ID,
        acf.ADD_DATE,
        acf.USERID,
        now() as refresh_time
  from  camdams.ACCOUNT_PLANT acf;


comment on materialized view camdsnap.ACCOUNT_FACILITY_SS is 'snapshot table for snapshot CAMDSNAP.ACCOUNT_FACILITY_SS';
