update camdaux.datacolumn 
set alias = 'noxrFormulaCode'
where name = 'nox_rate_formula_cd'
and datatable_id = 
	(select datatable_id 
	from camdaux.datatable 
	where dataset_cd = 'NOXRATECEMS');
commit;