SET DEFINE OFF;

--------------------
-- Unique Indexes --
--------------------

create unique index COMPLIANCE_EMISSION_SS_UQ on camdsnap.COMPLIANCE_EMISSION_SS ( comp_emiss_id );


---------------------
-- General Indexes --
---------------------

create index COMPLIANCE_EMISSION_SS_CMP_IX on camdsnap.COMPLIANCE_EMISSION_SS ( comp_period_id );
create index COMPLIANCE_EMISSION_SS_UNT_IX on camdsnap.COMPLIANCE_EMISSION_SS (  unit_id);
create index COMPLIANCE_EMISSION_SS_FAC_IX on camdsnap.COMPLIANCE_EMISSION_SS ( fac_id );
create index COMPLIANCE_EMISSION_SS_PAR_IX on camdsnap.COMPLIANCE_EMISSION_SS ( parameter_cd );