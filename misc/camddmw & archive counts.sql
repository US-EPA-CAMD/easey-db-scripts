SELECT pg_database_size('cgawsbrokerprodr97macy19l');
SELECT pg_size_pretty( pg_database_size('cgawsbrokerprodr97macy19l') );

SELECT MIN(op_year) AS "year" FROM camddmw.hour_unit_data;
SELECT MAX(op_year) AS "year" FROM camddmw.hour_unit_data;

SELECT MIN(op_year) AS "year" FROM camddmw_arch.hour_unit_data_a;
SELECT MAX(op_year) AS "year" FROM camddmw_arch.hour_unit_data_a;

select op_year, count(*) from camddmw_arch.hour_unit_data_a where op_year in (2010, 2011, 2012, 2013) group by op_year

select op_year, count(*) from camddmw_arch.hour_unit_data_a where op_year in (2015,2014,2013,2012) group by op_year
union all
select op_year, count(*) from camddmw.hour_unit_data where op_year in (2020,2021) group by op_year
order by op_year;

select count(*) from camddmw.account_compliance_dim;

select op_year, count(*) from camddmw.account_compliance_dim group by op_year order by op_year; --GOOD
select count(*) from camddmw.account_fact; --23859 to 23871
select count(*) from camddmw.account_owner_dim; --33510 to 33531
select count(*) from camddmw.allowance_holding_dim; --558536 to 558710
select op_year, count(*) from camddmw.annual_unit_data group by op_year order by op_year; --2021 we have 3962 to 4173
select op_year, count(*) from camddmw.control_year_dim group by op_year order by op_year; --RELOAD ALL YEARS
select op_year, count(*) from camddmw.day_unit_data group by op_year order by op_year; --RELOAD 2020,2021
select op_year, count(*) from camddmw.fuel_year_dim group by op_year order by op_year; --RELOAD 2020,2021
select op_year, count(*) from camddmw.hour_unit_data group by op_year order by op_year; --RELOAD 2020,2021
select op_year, count(*) from camddmw.month_unit_data group by op_year order by op_year; --RELOAD 2020,2021
select op_year, count(*) from camddmw.owner_display_fact group by op_year order by op_year; --RELOAD 2021,2022
select op_year, count(*) from camddmw.owner_year_dim group by op_year order by op_year; --RELOAD 2021,2022
select op_year, count(*) from camddmw.ozone_unit_data group by op_year order by op_year; --RELOAD 2021
select op_year, count(*) from camddmw.program_year_dim group by op_year order by op_year; --RELOAD 2021,2022
select op_year, count(*) from camddmw.quarter_unit_data group by op_year order by op_year; --RELOAD 2020,2021
select count(*) from camddmw.transaction_block_dim; -- 1376952 to 1377523
select count(*) from camddmw.transaction_fact; -- 507358 to 507624
select count(*) from camddmw.transaction_owner_dim; -- 1239000 to 1240133
select op_year, count(*) from camddmw.unit_compliance_dim group by op_year order by op_year; --GOOD
select op_year, count(*) from camddmw.unit_fact group by op_year order by op_year; --RELOAD 2021,2022
select op_year, count(*) from camddmw.unit_type_year_dim group by op_year order by op_year; --RELOAD 2021,2022

select op_year, count(*) from camddmw_arch.annual_unit_data_a group by op_year order by op_year; --RELOAD 1980,85,90,95-2016
select op_year, count(*) from camddmw_arch.day_unit_data_a group by op_year order by op_year; --RELOAD 1995-2016
select op_year, count(*) from camddmw_arch.hour_unit_data_a group by op_year order by op_year; --RELOAD 1995-2015, 2016 GOOD
select op_year, count(*) from camddmw_arch.month_unit_data_a group by op_year order by op_year; --RELOAD 1995-2016
select op_year, count(*) from camddmw_arch.ozone_unit_data_a group by op_year order by op_year; --RELOAD 1995-2016
select op_year, count(*) from camddmw_arch.quarter_unit_data_a group by op_year order by op_year; --RELOAD 1995-2016

-- RELATIONSHIPS
--camddmw.account_compliance_dim --> camddmw.account_fact
--transaction_block_dim_fk --> camddmw.transaction_fact
/*
delete from camddmw.account_compliance_dim;
delete from camddmw.account_fact;
delete from camddmw.account_owner_dim;
delete from camddmw.allowance_holding_dim;
delete from camddmw.transaction_block_dim;
delete from camddmw.transaction_fact;
delete from camddmw.transaction_owner_dim;

delete from camddmw.annual_unit_data where op_year in (2021,2022);
delete from camddmw.control_year_dim;
delete from camddmw.day_unit_data where op_year in (2020,2021,2022);
delete from camddmw.fuel_year_dim where op_year in (2020,2021,2022);
delete from camddmw.hour_unit_data where op_year in (2020,2021,2022);
delete from camddmw.month_unit_data where op_year in (2020,2021,2022);
delete from camddmw.owner_display_fact where op_year in (2021,2022);
delete from camddmw.owner_year_dim where op_year in (2021,2022);
delete from camddmw.ozone_unit_data where op_year in (2021,2022);
delete from camddmw.program_year_dim where op_year in (2021,2022);
delete from camddmw.quarter_unit_data where op_year in (2020,2021,2022);
delete from camddmw.unit_fact where op_year in (2021,2022);
delete from camddmw.unit_type_year_dim where op_year in (2021,2022);

delete from camddmw_arch.annual_unit_data_a; --RELOAD 1980,85,90,95-2016
delete from camddmw_arch.day_unit_data_a; --RELOAD 1995-2016
delete from camddmw_arch.month_unit_data_a; --RELOAD 1995-2016
delete from camddmw_arch.ozone_unit_data_a; --RELOAD 1995-2016
delete from camddmw_arch.quarter_unit_data_a; --RELOAD 1995-2016
delete from camddmw_arch.hour_unit_data_a where op_year in (2012, 2013);

/* VAMSHI RELEOAD ORDER
RELOAD THESE 1ST
  camddmw.unit_fact where op_year in (2021,2022);
  camddmw.account_fact
  camddmw.transaction_fact

RELOAD THESE 2ND
  camddmw.account_owner_dim
  camddmw.account_compliance_dim
  camddmw.allowance_holding_dim
  camddmw.transaction_block_dim
  camddmw.transaction_owner_dim
  camddmw.control_year_dim
  camddmw.fuel_year_dim where op_year in (2020,2021,2022)
  camddmw.owner_display_fact where op_year in (2021,2022)
  camddmw.owner_year_dim where op_year in (2021,2022)
  camddmw.program_year_dim where op_year in (2021,2022)
  camddmw.unit_type_year_dim where op_year in (2021,2022)

RELOAD THESE 3RD
  camddmw.ozone_unit_data where op_year in (2021,2022)
  camddmw.annual_unit_data where op_year in (2021,2022)
  camddmw.quarter_unit_data where op_year in (2020,2021,2022)
  camddmw.month_unit_data where op_year in (2020,2021,2022)
  camddmw.day_unit_data where op_year in (2020,2021,2022)
  camddmw.hour_unit_data where op_year in (2020,2021,2022)

RELOAD THESE 4TH (start with 2016 and go backwards)
  camddmw_arch.ozone_unit_data_a
  camddmw_arch.annual_unit_data_a
  camddmw_arch.quarter_unit_data_a
  camddmw_arch.month_unit_data_a
  camddmw_arch.day_unit_data_a
  camddmw_arch.hour_unit_data_a (2016 is good so start with 2015 on this one)
