/******************************************************************************************************************************
    
    IS_EXPECTED_FOR_COMPLIANCE_FOR_PLANT
    
    Determines whether a plant is expected for compliance for a particular regulatory program and year.
    
    
    Maitnenance History:
    
    Date        Programmer      Ticket      Description
    ----------  --------------  ----------  -----------------------------------------------------------------------------------
    2026-08-21  Dwayne Whitten  #7272       Created
******************************************************************************************************************************/
create or replace function camddmw.IS_EXPECTED_FOR_COMPLIANCE_FOR_PLANT
(
    facId_in    in  numeric,
    prgCd_in    in  varchar,
    opYear_in   in  numeric
)
    returns boolean
as
$body$
begin
    
    return exists(
                    select  1
                      from  camddmw.UNIT_FACT unf
                            join camddmw.PROGRAM_YEAR_DIM pyd using ( op_year, unit_id )
                     where  unf.op_year = opYear_in
                       and  unf.fac_id = facId_in
                       and  pyd.prg_code = prgCd_in
                       and  pyd.compliance_ind = 1
                 );
    
end;
$body$    
language 'plpgsql';
