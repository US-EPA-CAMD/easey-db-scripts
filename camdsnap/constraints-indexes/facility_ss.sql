------------------------
-- Unique Constraints --
------------------------

create unique index FACILITY_SS_FAC_UQ on camdsnap.FACILITY_SS (fac_id);
create unique index FACILITY_SS_ORIS_UQ on camdsnap.FACILITY_SS (oris_code);
