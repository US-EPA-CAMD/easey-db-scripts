select  uni.op_year,
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
            select  'Hour' Period, 1 Ord, dat.op_year,
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
              from  camddmw.HOUR_UNIT_DATA dat
             group
                by  dat.op_year
            union   all
            select  'Day' Period, 2 Ord, dat.op_year,
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
              from  camddmw.DAY_UNIT_DATA dat
             group
                by  dat.op_year
            union   all
            select  'Month' Period, 3 Ord, dat.op_year,
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
              from  camddmw.MONTH_UNIT_DATA dat
             group
                by  dat.op_year
            union   all
            select  'Quarter' Period, 4 Ord, dat.op_year,
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
              from  camddmw.QUARTER_UNIT_DATA dat
             group
                by  dat.op_year
            union   all
            select  'Annual' Period, 6 Ord, dat.op_year,
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
              from  camddmw.ANNUAL_UNIT_DATA dat
             group
                by  dat.op_year
        ) uni
 group
    by  uni.op_year,
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
    by  uni.op_year