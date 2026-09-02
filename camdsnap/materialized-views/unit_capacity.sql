create materialized view camdsnap.UNIT_CAPACITY_SS 
as 
select  cap.UNIT_CAP_ID,
        cap.UNIT_ID,
        cap.BEGIN_DATE,
        cap.END_DATE,
        cap.MAX_HI_CAPACITY,
        cap.ADD_DATE,
        cap.USERID,
        cap.UPDATE_DATE,
        now() as refresh_time
  from  camdecmps.UNIT_CAPACITY cap;


comment on materialized view camdsnap.UNIT_CAPACITY_SS is 'snapshot table for snapshot CAMDSNAP.UNIT_CAPACITY_SS';
