create or replace procedure camddmw.dm_refresh_allowance_compliance_dim_ams
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_allowance_compliance_dim_ams';

    -- Stacked Diagnostic Variables
    vErrorReturnedSqlstate      text;
    vErrorMessageText           text;
    vErrorPgExceptionDetail     text;
    vErrorPgExceptionHint       text;
    vErrorPgExceptionContext    text;
    vErrorSchemaName            text;
    vErrorTableName             text;
    vErrorColumnName            text;
    vErrorConstraintName        text;
begin
    
    ------------------
    -- Refresh Data --
    ------------------
    
    insert
      into  camddmw.ACCOUNT_COMPLIANCE_DIM
            ( 
                account_number, prg_code, op_year, units_affected,
                allocated, total_held, comp_year_emiss,
                other_deduct, current_deduct, total_deduct,
                carried_over, excess_emiss, penalty_amount,
                last_update_date, data_source, userid, add_date 
            )
    select  cmb.account_number,
            cmb.prg_code,
            cmb.op_year,
            cmb.units_affected,
            cmb.allocated,
            cmb.total_held,
            cmb.comp_year_emiss,
            cmb.other_deduct,
            cmb.current_deduct,
            cmb.total_deduct,
            cmb.carried_over,
            cmb.excess_emiss,
            cmb.penalty_amount,
            cmb.last_update_date,
            'AMS' as data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  (
                -----------------------
                -- Facility Accounts --
                -----------------------
                select  sel.account_number,
                        sel.account_type_cd,
                        sel.prg_cd as prg_code,
                        sel.op_year,
                        unt.units_affected,
                        alc.allocated,
                        hld.total_held,
                        case
                            when ( coalesce( cem.emiss_value, 0 ) > coalesce( sel.emiss_liability, 0 ) )
                            then coalesce( cem.emiss_value, 0 )
                            else coalesce( sel.emiss_liability, 0 )
                        end as comp_year_emiss,
                        case
                            when ( coalesce( sel.underutilization_liability, 0 ) + coalesce( sel.takeback_liability, 0 ) + coalesce( lia.other_deduct, 0 ) ) != 0
                            then ( coalesce( sel.underutilization_liability, 0 ) + coalesce( sel.takeback_liability, 0 ) + coalesce( lia.other_deduct, 0 ) )
                            else null
                        end as other_deduct,
                        0 as current_deduct,
                        ded.total_deduct,
                        case
                            when ( hld.total_held - ded.total_deduct ) >= 0
                            then ( hld.total_held - ded.total_deduct )
                            else 0
                        end as carried_over,
                        case
                            when xem.excess_emiss != 0
                            then xem.excess_emiss
                            else null
                        end as excess_emiss,
                        pen.penalty_amount,
                        sel.fac_id,
                        sel.unit_id,
                        sel.last_update_date
                  from  (
                            select  acc.account_number,
                                    acc.account_type_cd,
                                    prv.prg_cd,
                                    prv.prg_vintage_name::integer as op_year,
                                    acp.emiss_liability,
                                    acp.offset_liability,
                                    acp.takeback_liability,
                                    acp.underutilization_liability,
                                    acp.account_id,
                                    acp.account_comp_id,
                                    acp.comp_period_id,
                                    cmp.prg_vintage_id,
                                    fct.fac_id,
                                    fct.unit_id,
                                    greatest( acp.add_date, acp.update_date, fct.last_update_date ) as last_update_date
                              from  camdsnap.ACCOUNT_COMPLIANCE_SS acp
                                    join camdsnap.ACCOUNT_SS acc
                                      on acc.account_id = acp.account_id
                                    join camdsnap.COMPLIANCE_PERIOD_SS cmp
                                      on cmp.comp_period_id = acp.comp_period_id
                                    join camdsnap.PROGRAM_VINTAGE_SS prv
                                      on prv.prg_vintage_id = cmp.prg_vintage_id
                                    join camddmw.ACCOUNT_FACT fct
                                      on fct.account_number = acc.account_number
                                     and fct.prg_code = prv.prg_cd
                             where  acp.comp_status_cd = 'FINAL'
                               and  acc.account_type_cd = 'FACLTY'
                               and  (
                                        fullRefresh_in
                                        or
                                        ( greatest( acp.add_date, acp.update_date, fct.last_update_date ) >= increamentalRefreshDate_in )
                                        or
                                        exists
                                        (
                                            select  1
                                              from  camdsnap.TRANSACTION_SS trn
                                             where  trn.account_comp_id = acp.account_comp_id
                                               and  trn.trans_date >= increamentalRefreshDate_in
                                        )
                                        or
                                        exists
                                        (
                                            select  1
                                              from  camdsnap.TRANSACTION_SS chg
                                                    join camdsnap.TRANSACTION_SS trn
                                                      on trn.changed_trans_id = chg.trans_id
                                                     and trn.trans_date >= increamentalRefreshDate_in
                                             where  chg.account_comp_id = acp.account_comp_id
                                        )
                                    )
                        ) sel
                        join camdmd.PROGRAM_CODE prc --? was speced for PROGRAM_SS.Comp_Parameter_Cd, which does not exist
                          on prc.prg_cd = sel.prg_cd
                        join camdsnap.ACCOUNT_FACILITY_SS acf
                          on acf.account_id = sel.account_id
                        left join camdsnap.ACCOUNT_COMPLIANCE_PENALTY_SS pen
                          on pen.account_comp_id = sel.account_comp_id
                        left join camdsnap.COMPLIANCE_EMISSION_SS cem
                          on cem.fac_id = acf.fac_id
                         and cem.comp_period_id = sel.comp_period_id
                         and cem.parameter_cd = prc.comp_parameter_cd
                        -- Unit Information
                        left join lateral
                        (
                            select  string_agg( cmb.unit_name, ', ' order by lpad( cmb.unit_name, 6, ' ' ) collate "C" ) as units_affected
                              from  (
                                        select  unt.unitid as unit_name
                                          from  camdsnap.UNIT_SS unt
                                         where  unt.fac_id = acf.fac_id
                                           and  exists
                                                (
                                                    select  1
                                                      from  camddmw.PROGRAM_YEAR_DIM pyd
                                                     where  pyd.op_year = sel.op_year
                                                       and  pyd.unit_id = unt.unit_id
                                                       and  pyd.prg_code = sel.prg_cd
                                                       and  pyd.compliance_ind = 1
                                                )
                                        union   all
                                        select  unh.old_unitid as unit_name
                                          from  camdsnap.UNIT_HISTORY_SS unh
                                         where  unh.old_fac_id = acf.fac_id
                                           and  unh.unit_history_type_cd in ( 'LOGICAL', 'PHYSICAL' )
                                           and  extract( year from unh.effective_date ) > sel.op_year
                                           and  exists
                                                (
                                                    select  1
                                                      from  camddmw.PROGRAM_YEAR_DIM pyd
                                                     where  pyd.op_year = sel.op_year
                                                       and  pyd.unit_id = unh.unit_id
                                                       and  pyd.prg_code = sel.prg_cd
                                                       and  pyd.compliance_ind = 1
                                                )
                                    ) cmb
                        ) unt
                          on true
                        -- Total Held
                        left join lateral
                        (
                            select  coalesce( sum( acb.begin_balance ), 0 ) as total_held
                              from  camdsnap.ACCOUNT_COMPLIANCE_BALANCE_SS acb
                             where  acb.account_comp_id = sel.account_comp_id
                        ) hld
                          on true
                        -- Allocated
                        left join lateral
                        (
                            select  coalesce( sum( cmb.allocated ), 0 ) as allocated
                              from  (
                                        -- Buy Account Allowance Allocations for Facility
                                        select  ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  trn.buy_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                        union   all
                                        -- Buy Account Allowance Allocations for Facility Units
                                        select  ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.UNIT_SS unt
                                                join camdsnap.ACCOUNT_SS acc
                                                  on acc.account_number = unt.account
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.buy_account_id = acc.account_id
                                                 and trn.trans_status_cd = 'COMPLET'
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  unt.fac_id = acf.fac_id
                                        union   all
                                        -- Buy Account Reverse Allowance Allocations for Facility
                                        select  ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 0
                                                join camdsnap.TRANSACTION_SS rvt
                                                  on rvt.trans_id = trn.changed_trans_id
                                                 and rvt.trans_status_cd = 'REVERSE'
                                                join camdmd.TRANSACTION_TYPE_CODE rvc
                                                  on rvc.trans_type_cd = rvt.trans_type_cd
                                                 and rvc.allocation_ind = 1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  trn.buy_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                        union   all
                                        -- Buy Account Reverse Allowance Allocations for Facility Units
                                        select  ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.UNIT_SS unt
                                                join camdsnap.ACCOUNT_SS acc
                                                  on acc.account_number = unt.account
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.buy_account_id = acc.account_id
                                                 and trn.trans_status_cd = 'COMPLET'
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 0
                                                join camdsnap.TRANSACTION_SS rvt
                                                  on rvt.trans_id = trn.changed_trans_id
                                                 and rvt.trans_status_cd = 'REVERSE'
                                                join camdmd.TRANSACTION_TYPE_CODE rvc
                                                  on rvc.trans_type_cd = rvt.trans_type_cd
                                                 and rvc.allocation_ind = 1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  unt.fac_id = acf.fac_id
                                        union   all
                                        -- Sell Account Reverse Allocations for Facility
                                        select  -1 * ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = -1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  trn.sell_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                        union   all
                                        -- Sell Account Allowance Allocations for Facility Units
                                        select  -1 * ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.UNIT_SS unt
                                                join camdsnap.ACCOUNT_SS acc
                                                  on acc.account_number = unt.account
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.sell_account_id = acc.account_id
                                                 and trn.trans_status_cd = 'COMPLET'
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = -1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  unt.fac_id = acf.fac_id
                                        union   all
                                        -- Sell Account Reverse Allowance Allocations for Facility
                                        select  -1 * ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 0
                                                join camdsnap.TRANSACTION_SS rvt
                                                  on rvt.trans_id = trn.changed_trans_id
                                                 and rvt.trans_status_cd = 'REVERSE'
                                                join camdmd.TRANSACTION_TYPE_CODE rvc
                                                  on rvc.trans_type_cd = rvt.trans_type_cd
                                                 and rvc.allocation_ind = -1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  trn.sell_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                        union   all
                                        -- Sell Account Reverse Allowance Allocations for Facility Units
                                        select  -1 * ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.UNIT_SS unt
                                                join camdsnap.ACCOUNT_SS acc
                                                  on acc.account_number = unt.account
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.sell_account_id = acc.account_id
                                                 and trn.trans_status_cd = 'COMPLET'
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 0
                                                join camdsnap.TRANSACTION_SS rvt
                                                  on rvt.trans_id = trn.changed_trans_id
                                                 and rvt.trans_status_cd = 'REVERSE'
                                                join camdmd.TRANSACTION_TYPE_CODE rvc
                                                  on rvc.trans_type_cd = rvt.trans_type_cd
                                                 and rvc.allocation_ind = -1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                                 and trb.prg_vintage_id = sel.prg_vintage_id
                                         where  unt.fac_id = acf.fac_id
                                    ) cmb
                        ) alc
                          on true
                        -- Total Deducted
                        left join lateral
                        (
                            -- Emissions Adjustment Deduction (EMADJ)
                            -- Emissions Deduction (EMISS)
                            -- Underutilization Deduction (UNDERUT)
                            -- Deduction of Loaned Allowances (LO)
                            -- State Cap Deduction (SE)
                            -- Substitution Control by Contract Deduction (CC)
                            select  coalesce( sum( cmb.deduct ), 0 ) as total_deduct
                              from  (
                                        -- Deductions
                                        select  ( trb.end_number - trb.begin_number + 1 ) as deduct
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd in ( 'EMADJ', 'EMISS', 'UNDERUT', 'LO', 'SE', 'CC' )
                                        union   all
                                        -- Reverse Deductions
                                        select  ( trb.end_number - trb.begin_number + 1 ) as deduct
                                          from  camdsnap.TRANSACTION_SS rev
                                                join camdsnap.TRANSACTION_SS cor
                                                  on cor.changed_trans_id = rev.trans_id
                                                 and cor.trans_status_cd = 'COMPLET'
                                                 and cor.trans_type_cd = 'ERRCORR'
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = cor.trans_id
                                         where  rev.account_comp_id = sel.account_comp_id
                                           and  rev.trans_status_cd = 'REVERSE'
                                           and  rev.trans_type_cd in ( 'EMADJ', 'EMISS', 'UNDERUT', 'LO', 'SE', 'CC' )
                                        union all
                                        -- Compliance Problem Deductions
                                        select  prb.block_total as deduct
                                          from  camdsnap.COMPLIANCE_PROBLEM_TRANS_SS prb
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.trans_id = prb.trans_id
                                         where  prb.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd in ( 'EMADJ', 'EMISS', 'UNDERUT', 'LO', 'SE', 'CC' )
                                        union   all
                                        -- ARP Duductions for CAIRSO2
                                        select  acd.total_deduct as deduct
                                          from  camddmw.ACCOUNT_COMPLIANCE_DIM acd
                                         where  sel.prg_cd = 'CAIRSO2'
                                           and  acd.account_number = sel.account_number
                                           and  acd.prg_code = 'ARP'
                                           and  acd.op_year = sel.op_year
                                    ) cmb
                        ) ded
                          on true
                        -- Other Deduct (from Account Compliance Liability)
                        left join lateral
                        (
                            select  coalesce( sum( acl.liability_amount ), 0 ) as other_deduct
                              from  camdsnap.ACCOUNT_COMPLIANCE_LIAB_SS acl
                             where  acl.account_comp_id = sel.account_comp_id
                        ) lia
                          on true
                        -- Excess Emissions
                        left join lateral
                        (
                            select  coalesce( sum( cmb.excess_emiss ), 0 ) as excess_emiss
                              from  (
                                        -- Offset/Penalty Deduction
                                        select  sel.offset_liability as excess_emiss
                                        union   all
                                        -- Reverse Offset/Penalty Deduction
                                        select  ( trb.end_number - trb.begin_number + 1 ) as excess_emiss
                                          from  camdsnap.TRANSACTION_SS rev
                                                join camdsnap.TRANSACTION_SS cor
                                                  on cor.changed_trans_id = rev.trans_id
                                                 and cor.trans_status_cd = 'COMPLET'
                                                 and cor.trans_type_cd = 'ERRCORR'
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = cor.trans_id
                                         where  rev.account_comp_id = sel.account_comp_id
                                           and  rev.trans_status_cd = 'REVERSE'
                                           and  rev.trans_type_cd = 'OFFPEN'
                                        union all
                                        -- Compliance Problem Offset/Penalty Deduction
                                        select  prb.block_total as excess_emiss
                                          from  camdsnap.COMPLIANCE_PROBLEM_TRANS_SS prb
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.trans_id = prb.trans_id
                                         where  prb.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd = 'OFFPEN'
                                    )  cmb
                        ) xem
                          on true
                union   all
                -------------------
                -- Unit Accounts --
                -------------------
                select  sel.account_number,
                        sel.account_type_cd,
                        sel.prg_cd as prg_code,
                        sel.op_year,
                        case
                            when unt.account is not null
                            then unt.unitid
                            when unh.old_account_number is not null
                            then unh.old_unitid
                        end as units_affected,
                        alc.allocated,
                        hld.total_held,
                        case
                            when ( coalesce( cem.emiss_value, 0 ) > coalesce( sel.emiss_liability, 0 ) )
                            then coalesce( cem.emiss_value, 0 )
                            else coalesce( sel.emiss_liability, 0 )
                        end as comp_year_emiss,
                        case
                            when ( coalesce( sel.underutilization_liability, 0 ) + coalesce( sel.takeback_liability, 0 ) + coalesce( lia.other_deduct, 0 ) ) != 0
                            then ( coalesce( sel.underutilization_liability, 0 ) + coalesce( sel.takeback_liability, 0 ) + coalesce( lia.other_deduct, 0 ) )
                            else null
                        end as other_deduct,
                        0 as current_deduct,
                        ded.total_deduct,
                        case
                            when ( hld.total_held - ded.total_deduct ) >= 0
                            then ( hld.total_held - ded.total_deduct )
                            else 0
                        end as carried_over,
                        case
                            when xem.excess_emiss != 0
                            then xem.excess_emiss
                            else null
                        end as excess_emiss,
                        pen.penalty_amount,
                        sel.fac_id,
                        sel.unit_id,
                        sel.last_update_date
                  from  (
                            select  acc.account_number,
                                    acc.account_type_cd,
                                    prv.prg_cd,
                                    prv.prg_vintage_name::integer as op_year,
                                    acp.emiss_liability,
                                    acp.offset_liability,
                                    acp.takeback_liability,
                                    acp.underutilization_liability,
                                    acp.account_id,
                                    acp.account_comp_id,
                                    acp.comp_period_id,
                                    cmp.prg_vintage_id,
                                    fct.fac_id,
                                    fct.unit_id,
                                    greatest( acp.add_date, acp.update_date, fct.last_update_date ) as last_update_date
                              from  camdsnap.ACCOUNT_COMPLIANCE_SS acp
                                    join camdsnap.ACCOUNT_SS acc
                                      on acc.account_id = acp.account_id
                                    join camdsnap.COMPLIANCE_PERIOD_SS cmp
                                      on cmp.comp_period_id = acp.comp_period_id
                                    join camdsnap.PROGRAM_VINTAGE_SS prv
                                      on prv.prg_vintage_id = cmp.prg_vintage_id
                                    join camddmw.ACCOUNT_FACT fct
                                      on fct.account_number = acc.account_number
                                     and fct.prg_code = prv.prg_cd
                             where  acp.comp_status_cd = 'FINAL'
                               and  acc.account_type_cd = 'UNIT'
                               and  (
                                        fullRefresh_in
                                        or
                                        ( greatest( acp.add_date, acp.update_date, fct.last_update_date ) >= increamentalRefreshDate_in )
                                        or
                                        exists
                                        (
                                            select  1
                                              from  camdsnap.TRANSACTION_SS trn
                                             where  trn.account_comp_id = acp.account_comp_id
                                               and  trn.trans_date >= increamentalRefreshDate_in
                                        )
                                        or
                                        exists
                                        (
                                            select  1
                                              from  camdsnap.TRANSACTION_SS chg
                                                    join camdsnap.TRANSACTION_SS trn
                                                      on trn.changed_trans_id = chg.trans_id
                                                     and trn.trans_date >= increamentalRefreshDate_in
                                             where  chg.account_comp_id = acp.account_comp_id
                                        )
                                    )
                        ) sel
                        left join camdsnap.ACCOUNT_COMPLIANCE_PENALTY_SS pen
                          on pen.account_comp_id = sel.account_comp_id
                        left join camdsnap.UNIT_SS unt
                          on unt.account = sel.account_number
                        left join camdsnap.UNIT_HISTORY_SS unh
                          on unh.old_account_number = sel.account_number
                         and unh.unit_history_type_cd in ( 'LOGICAL', 'PHYSICAL' )
                         and extract( year from unh.effective_date ) > sel.op_year
                        left join camdsnap.COMPLIANCE_EMISSION_SS cem
                          on cem.unit_id = coalesce( unt.unit_id, unh.unit_id )
                         and cem.comp_period_id = sel.comp_period_id
                         and cem.parameter_cd = 'SO2'
                        -- Total Held
                        left join lateral
                        (
                            select  coalesce( sum( cmb.total_held ), 0 ) as total_held
                              from  (
                                        -- Compliance Balance
                                        select  acb.begin_balance as total_held
                                          from  camdsnap.ACCOUNT_COMPLIANCE_BALANCE_SS acb
                                         where  acb.account_comp_id = sel.account_comp_id
                                        union   all
                                        -- Internal Transfer to Reduce Offset Acquire
                                        select  ( trb.end_number - trb.begin_number + 1 ) as total_held
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd = 'TF'
                                        union   all
                                        -- Internal Transfer to Reduce Offset Sell
                                        select  -1 * ( trb.end_number - trb.begin_number + 1 ) as total_held
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.sell_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd = 'TF'
                                           and  exists
                                                (
                                                    select  1
                                                      from  camdsnap.ACCOUNT_COMPLIANCE_SS exs
                                                     where  exs.account_comp_id = trn.account_comp_id
                                                       and  exs.comp_period_id = sel.comp_period_id
                                                )
                                        union   all
                                        -- State Cap Issuance Transactions
                                        select  ( trb.end_number - trb.begin_number + 1 ) as total_held
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.buy_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd = 'SC'
                                           and  trb.prg_vintage_id = sel.prg_vintage_id
                                    )  cmb
                        ) hld
                          on null is null
                        -- Allocated
                        left join lateral
                        (
                            select  coalesce( sum( cmb.allocated ), 0 ) as allocated
                              from  (
                                        -- Allowance Allocations
                                        select  ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.buy_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trb.prg_vintage_id = sel.prg_vintage_id
                                        union   all
                                        -- Reverse Allowance Allocations
                                        select  ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 0
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.buy_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trb.prg_vintage_id = sel.prg_vintage_id
                                           and  exists
                                                (
                                                    select  1
                                                      from  camdsnap.TRANSACTION_SS xtr
                                                            join camdmd.TRANSACTION_TYPE_CODE xtt
                                                              on xtt.trans_type_cd = xtr.trans_type_cd
                                                             and xtt.allocation_ind = 1
                                                     where  xtr.trans_id = trn.changed_trans_id
                                                       and  xtr.trans_status_cd = 'REVERSE'
                                                )
                                        union   all
                                        -- Surrenders, Paybacks, and Terminations
                                        select  -1 * ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = -1
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.sell_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trb.prg_vintage_id = sel.prg_vintage_id
                                        union   all
                                        -- Reverse Surrenders, Paybacks, and Terminations
                                        select  ( trb.end_number - trb.begin_number + 1 ) as allocated
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdmd.TRANSACTION_TYPE_CODE ttc
                                                  on ttc.trans_type_cd = trn.trans_type_cd
                                                 and ttc.allocation_ind = 0
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.sell_account_id = sel.account_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trb.prg_vintage_id = sel.prg_vintage_id
                                           and  exists
                                                (
                                                    select  1
                                                      from  camdsnap.TRANSACTION_SS xtr
                                                            join camdmd.TRANSACTION_TYPE_CODE xtt
                                                              on xtt.trans_type_cd = xtr.trans_type_cd
                                                             and xtt.allocation_ind = -1
                                                     where  xtr.trans_id = trn.changed_trans_id
                                                       and  xtr.trans_status_cd = 'REVERSE'
                                                )
                                    )  cmb
                        ) alc
                          on null is null
                        -- Total Deductions
                        left join lateral
                        (
                            -- Emissions Adjustment Deduction (EMADJ)
                            -- Emissions Deduction (EMISS)
                            -- Deduction of Loaned Allowances (LO)
                            -- State Cap Deduction (SE)
                            -- Substitution Control by Contract Deduction (CC)
                            -- Underutilization Deduction (UNDERUT)
                            select  coalesce( sum( cmb.deduct ), 0 ) as total_deduct
                              from  (
                                        -- Deductions
                                        select  ( trb.end_number - trb.begin_number + 1 ) as deduct
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd in ( 'EMADJ', 'EMISS', 'UNDERUT', 'LO', 'SE', 'CC' )
                                        union   all
                                        -- Reverse Deductions
                                        select  ( trb.end_number - trb.begin_number + 1 ) as deduct
                                          from  camdsnap.TRANSACTION_SS rev
                                                join camdsnap.TRANSACTION_SS cor
                                                  on cor.changed_trans_id = rev.trans_id
                                                 and cor.trans_status_cd = 'COMPLET'
                                                 and cor.trans_type_cd = 'ERRCORR'
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = cor.trans_id
                                         where  rev.account_comp_id = sel.account_comp_id
                                           and  rev.trans_status_cd = 'REVERSE'
                                           and  rev.trans_type_cd in ( 'EMADJ', 'EMISS', 'UNDERUT', 'LO', 'SE', 'CC' )
                                        union all
                                        -- Compliance Problem Deductions
                                        select  prb.block_total as deduct
                                          from  camdsnap.COMPLIANCE_PROBLEM_TRANS_SS prb
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.trans_id = prb.trans_id
                                         where  prb.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd in ( 'EMADJ', 'EMISS', 'UNDERUT', 'LO', 'SE', 'CC' )
                                    )  cmb
                        ) ded
                          on null is null
                        -- Other Deduct (from Account Compliance Liability)
                        left join lateral
                        (
                            select  coalesce( sum( acl.liability_amount ), 0 ) as other_deduct
                              from  camdsnap.ACCOUNT_COMPLIANCE_LIAB_SS acl
                             where  acl.account_comp_id = sel.account_comp_id
                        ) lia
                          on true
                        -- Excess Emissions
                        left join lateral
                        (
                            select  coalesce( sum( cmb.excess_emiss ), 0 ) as excess_emiss
                              from  (
                                        -- Offset/Penalty Deduction
                                        select  ( trb.end_number - trb.begin_number + 1 ) as excess_emiss
                                          from  camdsnap.TRANSACTION_SS trn
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = trn.trans_id
                                         where  trn.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd = 'OFFPEN'
                                        union   all
                                        -- Reverse Offset/Penalty Deduction
                                        select  ( trb.end_number - trb.begin_number + 1 ) as excess_emiss
                                          from  camdsnap.TRANSACTION_SS rev
                                                join camdsnap.TRANSACTION_SS cor
                                                  on cor.changed_trans_id = rev.trans_id
                                                 and cor.trans_status_cd = 'COMPLET'
                                                 and cor.trans_type_cd = 'ERRCORR'
                                                join camdsnap.TRANSACTION_BLOCK_SS trb
                                                  on trb.trans_id = cor.trans_id
                                         where  rev.account_comp_id = sel.account_comp_id
                                           and  rev.trans_status_cd = 'REVERSE'
                                           and  rev.trans_type_cd = 'OFFPEN'
                                        union all
                                        -- Compliance Problem Offset/Penalty Deduction
                                        select  prb.block_total as excess_emiss
                                          from  camdsnap.COMPLIANCE_PROBLEM_TRANS_SS prb
                                                join camdsnap.TRANSACTION_SS trn
                                                  on trn.trans_id = prb.trans_id
                                         where  prb.account_comp_id = sel.account_comp_id
                                           and  trn.trans_status_cd = 'COMPLET'
                                           and  trn.trans_type_cd = 'OFFPEN'
                                    )  cmb
                        ) xem
                          on null is null
                 where  -- Exclude unit if cancelled and Emission Liability is 0.
                        not exists
                        (
                            select  1
                              from  camdsnap.UNIT_OP_STATUS_SS uos
                             where  uos.unit_id = coalesce( unt.unit_id, unh.unit_id )
                               and  uos.op_status = 'CAN'
                               and  sel.emiss_liability = 0
                        )
            ) cmb
     where  (
                cmb.comp_year_emiss != 0
                or
                cmb.other_deduct is not null
                or
                cmb.account_type_cd = 'FACLTY' and
                exists
                (
                    select  1
                      from  camddmw.UNIT_FACT unf
                            join camddmw.PROGRAM_YEAR_DIM pyd using ( op_year, unit_id )
                     where  unf.op_year = cmb.op_year
                       and  unf.fac_id = cmb.fac_id
                       and  pyd.prg_code = cmb.prg_code
                       and  pyd.compliance_ind = 1
                )
                or
                cmb.account_type_cd = 'UNIT' and
                exists
                (
                    select  1
                      from  camddmw.PROGRAM_YEAR_DIM pyd
                     where  pyd.op_year = cmb.op_year
                       and  pyd.unit_id = cmb.unit_id
                       and  pyd.prg_code = cmb.prg_code
                       and  pyd.compliance_ind = 1
                )
            )
     order
        by  cmb.prg_code
        on  conflict ( account_number, prg_code, op_year )
        do  update
               set  units_affected      = excluded.units_affected,
                    allocated           = excluded.allocated,
                    total_held          = excluded.total_held,
                    banked_held         = excluded.banked_held,
                    current_held        = excluded.current_held,
                    comp_year_emiss     = excluded.comp_year_emiss,
                    other_deduct        = excluded.other_deduct,
                    current_deduct      = excluded.current_deduct,
                    deduct_1_1          = excluded.deduct_1_1,
                    deduct_2_1          = excluded.deduct_2_1,
                    total_deduct        = excluded.total_deduct,
                    carried_over        = excluded.carried_over,
                    excess_emiss        = excluded.excess_emiss,
                    penalty_deduct_info = excluded.penalty_deduct_info,
                    total_req_deduct    = excluded.total_req_deduct,
                    add_date            = excluded.add_date,
                    userid              = excluded.userid,
                    data_source         = excluded.data_source;
    
    
    -- Return Values
    errorJson_out := null;
    result_out := true;
    
exception when others then
    get stacked diagnostics 
        vErrorReturnedSqlstate      = RETURNED_SQLSTATE,
        vErrorMessageText           = MESSAGE_TEXT,
        vErrorPgExceptionDetail     = PG_EXCEPTION_DETAIL,
        vErrorPgExceptionHint       = PG_EXCEPTION_HINT,
        vErrorPgExceptionContext    = PG_EXCEPTION_CONTEXT,
        vErrorSchemaName            = SCHEMA_NAME,
        vErrorTableName             = TABLE_NAME,
        vErrorColumnName            = COLUMN_NAME,
        vErrorConstraintName        = CONSTRAINT_NAME;
    
    errorJson_out := jsonb_build_object
                     (
                        'routine_name',             cProcedureName,
                        'returned_sqlstate',        vErrorReturnedSqlstate,
                        'message_text',             vErrorMessageText,
                        'pg_exception_detail',      vErrorPgExceptionDetail,
                        'pg_exception_hint',        vErrorPgExceptionHint,
                        'pg_exception_context',     vErrorPgExceptionContext,
                        'schema_name',              vErrorSchemaName,
                        'table_name',               vErrorTableName,
                        'column_name',              vErrorColumnName,
                        'constraint_name',          vErrorConstraintName
                     );
    
    result_out := false;
end;
$$
language plpgsql;
