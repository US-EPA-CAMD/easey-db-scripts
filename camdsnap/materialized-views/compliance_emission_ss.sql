create materialized view camdsnap.COMPLIANCE_EMISSION_SS
as 
select  cem.comp_emiss_id,
        cem.fac_id,
        cem.unit_id,
        cem.comp_period_id,
        cem.parameter_cd,
        cem.emiss_value,
        cem.data_source_cd,
        cem.severity_cd,
        cem.approval_cd,
        cem.add_date,
        cem.update_date,
        cem.userid,
        cem.stack_name
  from  camdams.COMPLIANCE_EMISSION cem;


comment on materialized view camdsnap.COMPLIANCE_EMISSION_SS is 'snapshot table for snapshot CAMDSNAP.COMPLIANCE_EMISSION_SS';
