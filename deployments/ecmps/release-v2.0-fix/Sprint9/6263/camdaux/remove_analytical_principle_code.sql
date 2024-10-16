DO $$
DECLARE
	groupCode text := 'MDM';
	datasetCode text := 'analytical-principle-codes';
	datatableId integer;
BEGIN
	DELETE FROM camdaux.dataset WHERE dataset_cd = datasetCode and group_cd = groupCode;
	
	SELECT datatable_id INTO datatableId FROM camdaux.datatable WHERE dataset_cd = datasetCode;
	
	DELETE FROM camdaux.datatable WHERE dataset_cd = datasetCode;
	
	DELETE FROM camdaux.datacolumn WHERE datatable_id = datatableId;
END $$;