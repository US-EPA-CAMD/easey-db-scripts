create materialized view camdsnap.ORIGINAL_ALLOCATION_SS 
as 
select  ora.unit_id,
        ora.phase1_allocation,
        ora.phase1_withholding,
        ora.phase2a_allocation,
        ora.phase2a_withholding,
        ora.phase2b_allocation,
        ora.phase2b_withholding,
        ora.optin_allocation1,
        ora.optin_allocation2,
        ora.exempt_ind,
        now() as refresh_time
  from  camdams.ORIGINAL_ALLOCATION ora;


comment on materialized view camdsnap.ORIGINAL_ALLOCATION_SS is 'snapshot table for snapshot CAMDSNAP.ORIGINAL_ALLOCATION_SS';
