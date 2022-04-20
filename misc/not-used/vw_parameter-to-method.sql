SELECT DISTINCT VALUE2 as 'VALUE',
	METHOD_CD_DESCRIPTION as [DESCRIPTION],
	VALUE1 FROM VW_CROSS_CHECK_CATALOG_VALUE C
INNER JOIN METHOD_CODE M
ON C.VALUE2 = M.METHOD_CD
WHERE CROSS_CHK_CATALOG_NAME='Method Parameter to Method to System Type'
ORDER BY VALUE2

SELECT DISTINCT d.parameter_cd, d.method_cd, cc.value2 as sub_data_cd
FROM VW_CROSS_CHECK_CATALOG_VALUE cc
INNER JOIN (
	SELECT DISTINCT
		value1 AS parameter_cd,
		value2 AS method_cd
	FROM VW_CROSS_CHECK_CATALOG_VALUE
	WHERE CROSS_CHK_CATALOG_NAME = 'Method Parameter to Method to System Type'
) d ON cc.value1 = d.method_cd
inner join substitute_data_code sdc ON cc.value2 = sdc.sub_data_cd
WHERE cross_chk_catalog_name = 'Method to Substitute Data Code'
order by d.parameter_cd, d.method_cd, cc.value2


SELECT DISTINCT VALUE2 as 'VALUE', METHOD_CD_DESCRIPTION as [DESCRIPTION], VALUE1 FROM VW_CROSS_CHECK_CATALOG_VALUE C INNER JOIN METHOD_CODE M ON C.VALUE2 = M.METHOD_CD WHERE CROSS_CHK_CATALOG_NAME='Method Parameter to Method to System Type' ORDER BY VALUE1
