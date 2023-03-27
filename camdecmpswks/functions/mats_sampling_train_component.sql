-- FUNCTION: camdecmpswks.mats_sampling_train_component(character varying, date, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.mats_sampling_train_component(character varying, date, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.mats_sampling_train_component(
	v_mon_sys_id character varying,
	v_op_date date,
	v_op_hour numeric)
    RETURNS TABLE(component_id character varying, component_identifier character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT st.COMPONENT_ID, c.COMPONENT_IDENTIFIER
	FROM camdecmpswks.SORBENT_TRAP sorb
	INNER JOIN camdecmpswks.SAMPLING_TRAIN st
		ON sorb.TRAP_ID = st.TRAP_ID
	INNER JOIN camdecmpswks.COMPONENT c
		ON st.COMPONENT_ID = c.COMPONENT_ID
	WHERE sorb.MON_SYS_ID = V_MON_SYS_ID AND
		V_OP_DATE + V_OP_HOUR * '1 hour'::interval
			BETWEEN
				sorb.BEGIN_DATE + sorb.BEGIN_HOUR * '1 hour'::interval
			AND
				sorb.END_DATE + sorb.END_HOUR * '1 hour'::interval
	
	UNION   ALL
    
	SELECT st.COMPONENT_ID, c.COMPONENT_IDENTIFIER
	FROM camdecmpswks.SORBENT_TRAP_SUPP_DATA sorb
	INNER JOIN camdecmpswks.SAMPLING_TRAIN_SUPP_DATA st
		ON sorb.TRAP_ID = st.TRAP_ID
	INNER JOIN camdecmpswks.COMPONENT c
		ON st.COMPONENT_ID = c.COMPONENT_ID
	WHERE sorb.MON_SYS_ID = V_MON_SYS_ID AND
		V_OP_DATE + V_OP_HOUR * '1 hour'::interval
			BETWEEN
				sorb.BEGIN_DATE + sorb.BEGIN_HOUR * '1 hour'::interval
			AND
				sorb.END_DATE + sorb.END_HOUR * '1 hour'::interval
        AND NOT EXISTS ( SELECT 1 FROM camdecmpswks.SORBENT_TRAP exs WHERE exs.TRAP_ID = sorb.TRAP_ID );
END
$BODY$;

-- FUNCTION: camdecmpswks.mats_sampling_train_component(character varying, date, numeric, integer)

DROP FUNCTION IF EXISTS camdecmpswks.mats_sampling_train_component(character varying, date, numeric, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.mats_sampling_train_component(
	v_mon_sys_id character varying,
	v_op_date date,
	v_op_hour numeric,
	v_train_num integer)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	COMP_ID character varying;
BEGIN
	IF V_TRAIN_NUM = 1 THEN
		SELECT COMPONENT_ID INTO COMP_ID
		FROM camdecmpswks.mats_sampling_train_component(v_mon_sys_id, v_op_date, v_op_hour)
        ORDER BY COMPONENT_IDENTIFIER ASC
		LIMIT 1;
	ELSE
		SELECT COMPONENT_ID INTO COMP_ID
		FROM camdecmpswks.mats_sampling_train_component(v_mon_sys_id, v_op_date, v_op_hour)
        ORDER BY COMPONENT_IDENTIFIER DESC
		LIMIT 1;
	END IF;

	RETURN COMP_ID;
END
$BODY$;
