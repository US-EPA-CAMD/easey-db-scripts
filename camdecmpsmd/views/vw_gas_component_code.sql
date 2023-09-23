-- View: camdecmpsmd.vw_gas_component_code

-- DROP VIEW camdecmpsmd.vw_gas_component_code;

CREATE OR REPLACE VIEW camdecmpsmd.vw_gas_component_code AS
SELECT
	COALESCE(gas_component_cd, gas_type_cd) as code,
	COALESCE(gas_component_description, gas_type_description) as description,
	can_combine_ind,
	balance_component_ind,
	'GCC' as group_cd
FROM camdecmpsmd.gas_component_code gcc
LEFT JOIN camdecmpsmd.gas_type_code gtc ON gcc.gas_component_cd = gtc.gas_type_cd
UNION
SELECT
	gas_type_cd as code,
	gas_type_description as description,
	null as can_combine_ind,
	null as balance_component_ind,
	'GTC' as group_cd
FROM camdecmpsmd.gas_type_code
WHERE gas_type_cd NOT IN (
	SELECT gas_component_cd FROM camdecmpsmd.gas_component_code
)
ORDER BY group_cd, code;
