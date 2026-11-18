create materialized view camdsnap.STAFF_AGENCY_SS 
as 
select  ppl.ppl_id,
        ppl.agency_id as agy_id,
        now() as refresh_time
  from  PERSON ppl
 where  ppl.agency_id is not null;


comment on materialized view camdsnap.STAFF_AGENCY_SS is 'snapshot table for snapshot CAMDSNAP.STAFF_AGENCY_SS';
