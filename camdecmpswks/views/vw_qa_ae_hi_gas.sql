-- View: camdecmpswks.vw_qa_ae_hi_gas

DROP VIEW IF EXISTS camdecmpswks.vw_qa_ae_hi_gas;

CREATE OR REPLACE VIEW camdecmpswks.vw_qa_ae_hi_gas
 AS
 SELECT ts.test_sum_id,
    ts.test_num,
    ts.test_reason_cd,
    ts.begin_date AS test_begin_date,
    ts.begin_hour AS test_begin_hour,
    ts.begin_min AS test_begin_min,
    ts.end_date AS test_end_date,
    ts.end_hour AS test_end_hour,
    ts.end_min AS test_end_min,
    ts.sys_type_cd AS noxe_sys_type_cd,
    ts.system_identifier AS noxe_system_identifier,
    ts.mon_sys_id AS noxe_mon_sys_id,
    ts.fuel_cd AS noxe_fuel_cd,
    ts.mon_loc_id,
    ts.fac_id,
    ts.location_identifier,
    ts.ae_corr_test_sum_id,
    ts.op_level_num,
    ts.ae_corr_test_run_id,
    ag.ae_hi_gas_id,
    ts.run_num,
    ts.begin_date,
    ts.begin_hour,
    ts.begin_min,
    ts.end_date,
    ts.end_hour,
    ts.end_min,
    ms.sys_type_cd,
    ms.system_identifier,
    ms.mon_sys_id,
    ag.gas_volume,
    ag.gas_gcv,
    ag.gas_hi,
    ag.userid,
    ag.add_date,
    ag.update_date
   FROM camdecmpswks.ae_hi_gas ag
     JOIN camdecmpswks.vw_qa_ae_correlation_test_run ts ON ag.ae_corr_test_run_id::text = ts.ae_corr_test_run_id::text
     JOIN camdecmpswks.monitor_system ms ON ag.mon_sys_id::text = ms.mon_sys_id::text;
