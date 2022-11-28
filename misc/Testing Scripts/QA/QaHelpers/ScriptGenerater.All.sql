
---------
-- QAT --
---------

use [EASEY-IN]
go

select  *
  from  [SqlGenQa].[PgQatInserts]( null, null, null )
 order
    by  1

    
---------
-- QCE --
---------

use [EASEY-IN]
go

select  *
  from  [SqlGenQa].[PgQceStatements]( null, null )
 order
    by  1


---------
-- TEE --
---------

use [EASEY-IN]
go

select  *
  from  [SqlGenQa].[PgTeeStatements]( null, null )
 order
    by  1
