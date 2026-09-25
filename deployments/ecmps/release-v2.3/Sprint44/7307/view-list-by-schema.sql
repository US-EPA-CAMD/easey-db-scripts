-- Run before deployment to capture the baseline and after deployment to capture the result.

select  table_schema as schema_name,
        table_name as view_name
  from  information_schema.VIEWS
 where  table_schema like 'camd%'
 order
    by  schema_name,
        view_name;
