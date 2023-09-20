select 'all', rp.calendar_year as year, count(*) from camdecmps.emission_view_all join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'co2appd', rp.calendar_year as year, count(*) from camdecmps.emission_view_co2appd join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'co2calc', rp.calendar_year as year, count(*) from camdecmps.emission_view_co2calc join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'co2cems', rp.calendar_year as year, count(*) from camdecmps.emission_view_co2cems join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'co2dailyfuel', rp.calendar_year as year, count(*) from camdecmps.emission_view_co2dailyfuel join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'dailycal', rp.calendar_year as year, count(*) from camdecmps.emission_view_dailycal join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'hiappd', rp.calendar_year as year, count(*) from camdecmps.emission_view_hiappd join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'hicems', rp.calendar_year as year, count(*) from camdecmps.emission_view_hicems join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'hiunitstack', rp.calendar_year as year, count(*) from camdecmps.emission_view_hiunitstack join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'lme', rp.calendar_year as year, count(*) from camdecmps.emission_view_lme join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'massoilcalc', rp.calendar_year as year, count(*) from camdecmps.emission_view_massoilcalc join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'matshcl', rp.calendar_year as year, count(*) from camdecmps.emission_view_matshcl join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'matshf', rp.calendar_year as year, count(*) from camdecmps.emission_view_matshf join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'matshg', rp.calendar_year as year, count(*) from camdecmps.emission_view_matshg join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'matsso2', rp.calendar_year as year, count(*) from camdecmps.emission_view_matsso2 join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'matssorbent', rp.calendar_year as year, count(*) from camdecmps.emission_view_matssorbent join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'matsweekly', rp.calendar_year as year, count(*) from camdecmps.emission_view_matsweekly join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'moisture', rp.calendar_year as year, count(*) from camdecmps.emission_view_moisture join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'noxappemixedfuel', rp.calendar_year as year, count(*) from camdecmps.emission_view_noxappemixedfuel join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'noxappesinglefuel', rp.calendar_year as year, count(*) from camdecmps.emission_view_noxappesinglefuel join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'noxmasscems', rp.calendar_year as year, count(*) from camdecmps.emission_view_noxmasscems join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'noxratecems', rp.calendar_year as year, count(*) from camdecmps.emission_view_noxratecems join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'otherdaily', rp.calendar_year as year, count(*) from camdecmps.emission_view_otherdaily join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'so2appd', rp.calendar_year as year, count(*) from camdecmps.emission_view_so2appd join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year union
select 'so2cems', rp.calendar_year as year, count(*) from camdecmps.emission_view_so2cems join camdecmpsmd.reporting_period rp using (rpt_period_id) group by year
order by 1,2
