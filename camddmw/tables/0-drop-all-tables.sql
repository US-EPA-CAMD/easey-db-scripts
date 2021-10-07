-- Ensure drop order is reversed from the order in which the tables are created
-- Tables are created in the proper order 1-N based on the number at the beginning of the file name

DROP TABLE camddmw.account_compliance_dim;
DROP TABLE camddmw.account_fact;
DROP TABLE camddmw.account_owner_dim;
DROP TABLE camddmw.allowance_holding_dim;
DROP TABLE camddmw.annual_unit_data;
DROP TABLE camddmw.control_year_dim;
DROP TABLE camddmw.day_unit_data;
DROP TABLE camddmw.fuel_year_dim;
DROP TABLE camddmw.hour_unit_data;
DROP TABLE camddmw.month_unit_data;
DROP TABLE camddmw.owner_display_fact;
DROP TABLE camddmw.owner_year_dim;
DROP TABLE camddmw.ozone_unit_data;
DROP TABLE camddmw.program_year_dim;
DROP TABLE camddmw.quarter_unit_data;
DROP TABLE camddmw.transaction_block_dim;
DROP TABLE camddmw.transaction_fact;
DROP TABLE camddmw.transaction_owner_dim;
DROP TABLE camddmw.unit_compliance_dim;
DROP TABLE camddmw.unit_fact;
DROP TABLE camddmw.unit_type_year_dim;
