with
    sel as
    (
        select  lst.oris_code,
                lst.unitid,
                prd.rpt_period_id,
                prd.period_abbreviation as quarter
          from  (
                    select     10 as oris_code, '1'      as unitid, 2023 as calendar_year, 3 as quarter union
                    select     10 as oris_code, '2'      as unitid, 2023 as calendar_year, 3 as quarter union
                    select   1250 as oris_code, '4'      as unitid, 2023 as calendar_year, 3 as quarter union
                    select   2832 as oris_code, '7'      as unitid, 2023 as calendar_year, 3 as quarter union
                    select   3297 as oris_code, 'WAT1'   as unitid, 2023 as calendar_year, 3 as quarter union
                    select   3297 as oris_code, 'WAT2'   as unitid, 2023 as calendar_year, 3 as quarter union
                    select   3470 as oris_code, 'WAP8'   as unitid, 2023 as calendar_year, 3 as quarter union
                    select   4041 as oris_code, '5'      as unitid, 2023 as calendar_year, 3 as quarter union
                    select   4041 as oris_code, '6'      as unitid, 2023 as calendar_year, 3 as quarter union
                    select   6166 as oris_code, 'MB1'    as unitid, 2023 as calendar_year, 3 as quarter union
                    select   6166 as oris_code, 'MB2'    as unitid, 2023 as calendar_year, 3 as quarter union
                    select   7900 as oris_code, 'SH2'    as unitid, 2023 as calendar_year, 3 as quarter union
                    select  50368 as oris_code, 'CT1'    as unitid, 2023 as calendar_year, 3 as quarter
                ) lst
                join camdecmpsmd.REPORTING_PERIOD prd using ( calendar_year, quarter )
    )
select  uni.oris_code,
        uni.facility_name,
        uni.unit_name,
        uni.quarter,
        string_agg( uni.Period, ', ' order by uni.Ord ) Periods,
        uni.op_time,
        uni.op_hours,
        uni.gload,
        uni.sload,
        uni.tload,
        uni.hit,
        uni.so2m,
        uni.so2r,
        uni.co2m,
        uni.co2r,
        uni.noxm,
        uni.noxr
  from  (
            select  fac.oris_code,
                    fac.facility_name,
                    unt.unitid as unit_name,
                    'Hour' Period, 1 Ord,
                    sel.quarter,
                    sum(dat.op_time) op_time,
                    sum(ceil(dat.op_time)) op_hours,
                    sum(dat.gload * dat.op_time) gload,
                    sum(dat.sload * dat.op_time) sload,
                    sum(dat.tload * dat.op_time) tload,
                    sum(dat.heat_input) hit,
                    sum(dat.so2_mass) so2m,
                    avg(dat.so2_rate) so2r,
                    sum(dat.co2_mass) co2m,
                    avg(dat.co2_rate) co2r,
                    sum(dat.nox_mass) noxm,
                    avg(dat.nox_rate) noxr
              from  sel
                    join camd.PLANT fac using ( oris_code )
                    join camd.UNIT unt using ( fac_id, unitid )
                    join camddmw.HOUR_UNIT_DATA dat using ( unit_id, rpt_period_id )
             group
                by  fac.oris_code,
                    fac.facility_name,
                    unt.unitid,
                    sel.quarter
            union   all
            select  fac.oris_code,
                    fac.facility_name,
                    unt.unitid as unit_name,
                    'Day' Period, 2 Ord,
                    sel.quarter,
                    sum(dat.sum_op_time) op_time,
                    sum(dat.count_op_time) op_hours,
                    sum(dat.gload) gload,
                    sum(dat.sload) sload,
                    sum(dat.tload) tload,
                    sum(dat.heat_input) hit,
                    sum(dat.so2_mass_lbs) so2m,
                    case when sum(dat.so2_rate_count) > 0 then sum(dat.so2_rate_sum) / sum(dat.so2_rate_count) else null end so2r,
                    sum(dat.co2_mass) co2m,
                    case when sum(dat.co2_rate_count) > 0 then sum(dat.co2_rate_sum) / sum(dat.co2_rate_count) else null end co2r,
                    sum(dat.nox_mass_lbs) noxm,
                    case when sum(dat.nox_rate_count) > 0 then sum(dat.nox_rate_sum) / sum(dat.nox_rate_count) else null end noxr
              from  sel
                    join camd.PLANT fac using ( oris_code )
                    join camd.UNIT unt using ( fac_id, unitid )
                    join camddmw.DAY_UNIT_DATA dat using ( unit_id, rpt_period_id )
             group
                by  fac.oris_code,
                    fac.facility_name,
                    unt.unitid,
                    sel.quarter
            union   all
            select  fac.oris_code,
                    fac.facility_name,
                    unt.unitid as unit_name,
                    'Month' Period, 3 Ord,
                    sel.quarter,
                    sum(dat.sum_op_time) op_time,
                    sum(dat.count_op_time) op_hours,
                    sum(dat.gload) gload,
                    sum(dat.sload) sload,
                    sum(dat.tload) tload,
                    sum(dat.heat_input) hit,
                    sum(dat.so2_mass_lbs) so2m,
                    case when sum(dat.so2_rate_count) > 0 then sum(dat.so2_rate_sum) / sum(dat.so2_rate_count) else null end so2r,
                    sum(dat.co2_mass) co2m,
                    case when sum(dat.co2_rate_count) > 0 then sum(dat.co2_rate_sum) / sum(dat.co2_rate_count) else null end co2r,
                    sum(dat.nox_mass_lbs) noxm,
                    case when sum(dat.nox_rate_count) > 0 then sum(dat.nox_rate_sum) / sum(dat.nox_rate_count) else null end noxr
              from  sel
                    join camd.PLANT fac using ( oris_code )
                    join camd.UNIT unt using ( fac_id, unitid )
                    join camddmw.MONTH_UNIT_DATA dat using ( unit_id, rpt_period_id )
             group
                by  fac.oris_code,
                    fac.facility_name,
                    unt.unitid,
                    sel.quarter
            union   all
            select  fac.oris_code,
                    fac.facility_name,
                    unt.unitid as unit_name,
                    'Quarter' Period, 4 Ord,
                    sel.quarter,
                    sum(dat.sum_op_time) op_time,
                    sum(dat.count_op_time) op_hours,
                    sum(dat.gload) gload,
                    sum(dat.sload) sload,
                    sum(dat.tload) tload,
                    sum(dat.heat_input) hit,
                    sum(dat.so2_mass_lbs) so2m,
                    case when sum(dat.so2_rate_count) > 0 then sum(dat.so2_rate_sum) / sum(dat.so2_rate_count) else null end so2r,
                    sum(dat.co2_mass) co2m,
                    case when sum(dat.co2_rate_count) > 0 then sum(dat.co2_rate_sum) / sum(dat.co2_rate_count) else null end co2r,
                    sum(dat.nox_mass_lbs) noxm,
                    case when sum(dat.nox_rate_count) > 0 then sum(dat.nox_rate_sum) / sum(dat.nox_rate_count) else null end noxr
              from  sel
                    join camd.PLANT fac using ( oris_code )
                    join camd.UNIT unt using ( fac_id, unitid )
                    join camddmw.QUARTER_UNIT_DATA dat using ( unit_id, rpt_period_id )
             group
                by  fac.oris_code,
                    fac.facility_name,
                    unt.unitid,
                    sel.quarter
        ) uni
 group
    by  uni.oris_code,
        uni.facility_name,
        uni.unit_name,
        uni.quarter,
        uni.op_time,
        uni.op_hours,
        uni.gload,
        uni.sload,
        uni.tload,
        uni.hit,
        uni.so2m,
        uni.so2r,
        uni.co2m,
        uni.co2r,
        uni.noxm,
        uni.noxr
 order
    by  uni.oris_code,
        uni.facility_name,
        uni.unit_name,
        uni.quarter