-- Run before deployment to capture the baseline and after deployment to capture the result.

select  table_schema as schema_name,
        count( 1 ) view_count
  from  information_schema.VIEWS
 where  table_schema like 'camd%'
 group
    by  table_schema
 order
    by  schema_name;
