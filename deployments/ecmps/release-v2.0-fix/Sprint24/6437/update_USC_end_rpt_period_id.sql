/* Formatted on 3/11/2026 4:15:04 PM (QP5 v5.300) */
MERGE INTO unit_stack_configuration d
     USING (   --TODO: limit to only update records that are linked to an active MP with all units retired (same set of MPs as in the MP end script for this ticket)
     SELECT usc.config_id,
       usc.unit_id,
       usc.stack_pipe_id,
       usc.begin_date,
       uos.begin_date AS unit_retire_date,
       sp.retire_date AS stack_pipe_retire_date,
       LEAST (uos.begin_date, NVL (sp.retire_date, uos.begin_date))
           AS end_date
  FROM unit_stack_configuration  usc
       INNER JOIN unit_op_status uos
           ON     usc.unit_id = uos.unit_id
              AND uos.OP_STATUS_CD = 'RET'
              AND uos.end_date IS NULL
       INNER JOIN stack_pipe sp ON usc.stack_pipe_id = sp.stack_pipe_id
 WHERE usc.end_date IS NULL) s
        ON (d.config_id = s.config_id)
WHEN MATCHED
THEN
    UPDATE SET
        d.USERID = 'ECMPS20',
        d.UPDATE_DATE = SYSDATE,
        d.END_DATE = s.end_date;
