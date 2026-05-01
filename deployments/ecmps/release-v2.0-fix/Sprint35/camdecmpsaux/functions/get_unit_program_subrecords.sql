DROP FUNCTION IF EXISTS camdecmpsaux.get_unit_program_subrecords(numeric, character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpsaux.get_unit_program_subrecords(
  p_fac_id numeric,
  p_unitid character varying,
  p_program_code character varying
)
RETURNS TABLE (
  unitId character varying,
  programCode character varying,
  programDescription character varying,
  unitTypeDescription character varying,
  commOpDate date,
  comrOpDate date,
  opStatusDescription character varying,
  unitMonitorCertBeginDate date,
  unitMonitorCertDeadline date,
  emissionsRecordingBeginDate date
)
AS $$
BEGIN
  RETURN QUERY
  SELECT  
    unt.unitid,
    unp.prg_cd,
    prc.prg_description,
    utc.unit_type_description,
    unt.comm_op_date,
    unt.comr_op_date,
    osc.op_status_description,
    unp.unit_monitor_cert_begin_date,
    unp.unit_monitor_cert_deadline,
    unp.emissions_recording_begin_date
  FROM camd.unit unt
  JOIN camd.unit_program unp USING (unit_id)
  JOIN camdmd.program_code prc USING (prg_cd)
  LEFT JOIN camd.unit_boiler_type ubt 
    ON ubt.unit_id = unt.unit_id AND ubt.end_date IS NULL
  LEFT JOIN camdmd.unit_type_code utc USING (unit_type_cd)
  LEFT JOIN camd.unit_op_status uos 
    ON uos.unit_id = unt.unit_id AND uos.end_date IS NULL
  LEFT JOIN camdmd.operating_status_code osc USING (op_status_cd)
  WHERE unt.fac_id = p_fac_id
    AND unt.unitid = p_unitid
    AND prc.prg_cd = p_program_code;
END;
$$ LANGUAGE plpgsql;