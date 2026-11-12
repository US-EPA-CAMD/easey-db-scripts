create or replace procedure camddmw.dm_refresh_allowance_compliance_dim
(
    in  fullRefresh_in              boolean,
    in  increamentalRefreshDate_in  date,
    out errorJson_out               json,
    out result_out                  boolean
)
as
$$
declare
    cProcedureName constant text := 'dm_refresh_allowance_compliance_dim';

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
                allocated, total_held, banked_held, current_held, comp_year_emiss,
                other_deduct, current_deduct, deduct_1_1, deduct_2_1, total_deduct,
                carried_over, excess_emiss, penalty_deduct_info, total_req_deduct,
                data_source, userid, add_date 
            )
    select  cmb.acctnum_id as account_number,
            cmb.prg_code,
            cmb.compyear_dt as op_year,
            unt.units_affected,
            alo.allocated,
            tbd.total_held,
            tbd.banked_held,
            tbd.current_held,
            tad.comp_year_emiss,
            oth.other_deduct,
            ded.current_deduct,
            ded.deduct_1_1,
            ded.deduct_2_1,
            ded.total_deduct,
            greatest( tbd.total_held - ded.total_deduct, 0 ) as carried_over,
            exc.excess_emiss,
            pen.penalty_deduct_info,
            case 
                when coalesce( tad.comp_year_emiss, 0 ) + coalesce( oth.other_deduct, 0 ) != 0
                then coalesce( tad.comp_year_emiss, 0 ) + coalesce( oth.other_deduct, 0 )
                else null
            end as total_req_deduct,
            'NATS' as data_source,
            'DMLOAD' as userid,
            now() as add_date
      from  (
                -- Allowance Deductions
                select  tad.acctnum_id,
                        'UA' as accttype_cd,
                        tad.compyear_dt::integer as compyear_dt,
                        case when tad.compyear_dt::integer <= 2002 then 'OTC' else 'NBP' end as prg_code
                  from  camdnats.TARS_ALLW_DED tad
                        join camddmw.ACCOUNT_FACT acf
                          on acf.account_number = tad.acctnum_id
                         and acf.prg_code = case when tad.compyear_dt::integer <= 2002 then 'OTC' else 'NBP' end
                 where  exists
                        (
                            select  1
                              from  camdnats.TSYSDATA exs
                             where  exs.compyear_dt::integer = tad.compyear_dt::integer
                               and  exs.status_ind = 'F'
                        )
                   and  (
                            fullRefresh_in
                            or
                            ( acf.add_date >= increamentalRefreshDate_in )
                            or
                            exists
                            (
                                select  1
                                  from  camdnats.TTRANSACT xtr
                                 where  xtr.sellacct_id = tad.acctnum_id
                                   and  xtr.compyear_dt = tad.compyear_dt
                                   and  xtr.trantype_cd in ( 'PE', 'TB', 'TE' )
                                   and  xtr.cnfrmdte_dt >= increamentalRefreshDate_in
                            )
                            or
                            exists
                            (
                                select  1
                                  from  camdnats.TTRANSACT xt1
                                        join camdnats.TTRANSACT xt2
                                          on xt2.chgdtran_cnt = xt1.tranevnt_cnt
                                         and xt2.trantype_cd in ( 'EC', 'ER' )
                                         and xt2.cnfrmdte_dt >= increamentalRefreshDate_in
                                 where  xt1.sellacct_id = tad.acctnum_id
                                   and  xt1.compyear_dt = tad.compyear_dt
                                   and  xt1.trantype_cd in ( 'PE', 'TB', 'TE' )
                            )
                        )
                union   all
                -- Overdraft Deductions
                select  trn.sellacct_id as acctnum_id,
                        'UA' as accttype_cd,
                        odd.compyear_dt::integer as compyear_dt,
                        case when odd.compyear_dt::integer <= 2002 then 'OTC' else 'NBP' end as prg_code
                  from  camdnats.TARS_OVDFT_DED odd
                        join camdnats.TTRANSACT trn using ( tranevnt_cnt )
                        join camddmw.ACCOUNT_FACT acf
                          on acf.account_number = odd.acctnum_id
                         and acf.prg_code = case when odd.compyear_dt::integer <= 2002 then 'OTC' else 'NBP' end
                 where  exists
                        (
                            select  1
                              from  camdnats.TSYSDATA exs
                             where  exs.compyear_dt::integer = odd.compyear_dt::integer
                               and  exs.status_ind = 'F'
                        )
                   and  (
                            fullRefresh_in
                            or
                            ( acf.add_date >= increamentalRefreshDate_in )
                            or
                            exists
                            (
                                select  1
                                  from  camdnats.TTRANSACT xtr
                                 where  xtr.sellacct_id = trn.sellacct_id
                                   and  xtr.compyear_dt = odd.compyear_dt
                                   and  xtr.trantype_cd in ( 'PE', 'TB', 'TE' )
                                   and  xtr.cnfrmdte_dt >= increamentalRefreshDate_in
                            )
                            or
                            exists
                            (
                                select  1
                                  from  camdnats.TTRANSACT xt1
                                        join camdnats.TTRANSACT xt2
                                          on xt2.chgdtran_cnt = xt1.tranevnt_cnt
                                         and xt2.trantype_cd in ( 'EC', 'ER' )
                                         and xt2.cnfrmdte_dt >= increamentalRefreshDate_in
                                 where  xt1.sellacct_id = trn.sellacct_id
                                   and  xt1.compyear_dt = odd.compyear_dt
                                   and  xt1.trantype_cd in ( 'PE', 'TB', 'TE' )
                            )
                        )
                union   all
                -- Allowance Deductions (Overdraft)
                select  acc.acctnum_id,
                        acc.accttype_cd,
                        sys.compyear_dt::integer as compyear_dt,
                        case when sys.compyear_dt::integer <= 2002 then 'OTC' else 'NBP' end as prg_code
                  from  camdnats.TACCOUNT acc
                        join camdnats.TSYSDATA sys
                          on sys.status_ind = 'F'
                        join camddmw.ACCOUNT_FACT acf
                          on acf.account_number = acc.acctnum_id
                         and acf.prg_code = case when sys.compyear_dt::integer <= 2002 then 'OTC' else 'NBP' end
                 where  acc.accttype_cd = 'OD'
                   and  exists
                        (
                           select  1
                             from  camdnats.TARS_ALLW_DED exs
                            where  substr( exs.acctnum_id, 1, 6 ) = substr( acc.acctnum_id, 1, 6 )
                              and  exs.compyear_dt::integer <= sys.compyear_dt::integer
                           having  ( count( 1 ) > 1 )
                        )
                   and  ( fullRefresh_in or ( acf.add_date >= increamentalRefreshDate_in ) )
            ) cmb
            -- Unit Information
            left join lateral
            (
                select  cmb.acctnum_id,
                        null as unit_id,
                        'OVERDRAFT' as units_affected
                 where  cmb.accttype_cd = 'OD'
                union
                select  cmb.acctnum_id,
                        unt.unit_id,
                        unt.unitid as units_affected
                  from  camdsnap.UNIT_SS unt
                 where  coalesce( cmb.accttype_cd, '00' ) != 'OD'
                   and  unt.account = cmb.acctnum_id
                union
                select  cmb.acctnum_id,
                        unh.unit_id,
                        unh.old_unitid as units_affected
                  from  camdsnap.UNIT_HISTORY_SS unh
                 where  coalesce( cmb.accttype_cd, '00' ) != 'OD'
                   and  unh.old_account_number = cmb.acctnum_id
                   and  not exists
                    (
                        select  1
                          from  camdsnap.UNIT_SS exs
                         where  exs.account = cmb.acctnum_id
                    )
            ) unt
              on true
            -- Held Values
            left join lateral
            (
                select  sum( case when sub.compyear_dt::integer = cmb.compyear_dt then sub.balance_tot else 0 end ) as total_held,
                        sum( case when sub.allwyear_dt = cmb.compyear_dt then sub.balance_tot else 0 end ) as current_held,
                        sum( case when sub.allwyear_dt > cmb.compyear_dt then sub.balance_tot else 0 end ) as banked_held
                  from  camdnats.TARS_BAL_DED sub
                 where  sub.acctnum_id = cmb.acctnum_id
                   and  sub.compyear_dt::integer = cmb.compyear_dt
            ) tbd
              on true
            -- Compliance Year Emissions
            left join lateral
            (
                select  sum
                        (
                            case
                                when sub.compyear_dt::integer = cmb.compyear_dt and sub.dedtype_cd = 'EM'
                                then sub.allwdct_cnt
                                else 0
                            end
                        ) as comp_year_emiss
                  from  camdnats.TARS_ALLW_DED sub
                 where  cmb.accttype_cd = 'UA'
                   and  sub.acctnum_id = cmb.acctnum_id
                union
                select  null as comp_year_emiss
                 where  coalesce( cmb.accttype_cd, '00' ) != 'UA'
            ) tad
              on true
            -- Allocated
            left join lateral
            (
                select  coalesce( sum( sub.allocated ), 0 ) as allocated
                  from  (
                            -- Determine Allowances Allocated
                            select  ( alw.serend_cnt - alw.serstart_cnt + 1 ) as allocated
                              from  camdnats.TTRANSACT trn
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                                     and alw.allwyear_dt = cmb.compyear_dt
                             where  trn.buyacct_id = cmb.acctnum_id
                               and  trn.trantype_cd in ( 'RC', 'IA', 'OI', 'SA' )
                               and  trn.transtat_cd = 'CP'
                            union all
                            -- Determine Allowances Allocated Error Corrections
                            select  ( alw.serend_cnt - alw.serstart_cnt + 1 ) as allocated
                              from  camdnats.TTRANSACT trn
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                                     and alw.allwyear_dt = cmb.compyear_dt
                             where  trn.buyacct_id = cmb.acctnum_id
                               and  trn.trantype_cd = 'EC'
                               and  trn.transtat_cd = 'CP'
                               and  exists
                                    (
                                        select  1
                                          from  camdnats.TTRANSACT
                                         where  tranevnt_cnt = trn.chgdtran_cnt
                                           and  trantype_cd in ( 'RC', 'IA', 'OI', 'SA' )
                                           and  transtat_cd = 'RV'
                                    )
                        )sub
            ) alo
              on true
            -- Deductions
            left join lateral
            (                        
                select  sum( sub.current_deduct ) as current_deduct,
                        sum( sub.deduct_1_1 ) as deduct_1_1,
                        sum( sub.deduct_2_1 ) as deduct_2_1,
                        ( coalesce( sum( sub.current_deduct ), 0 ) + coalesce( sum( sub.deduct_1_1 ), 0 ) + coalesce( sum( sub.deduct_2_1 ), 0 ) ) as total_deduct
                  from  (
                            -- Takeback for Underutilization, Emissions Deduction, and Terminate NOx Budget Programs Allowances
                            select  sum
                                    (
                                        case
                                            when ( alw.allwyear_dt = cmb.compyear_dt )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as current_deduct,
                                    sum
                                    (
                                        case
                                            when ( trn.trantype_cd = 'TN' )
                                            then 0
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( trim( alw.allwtrans_cd ) = '1' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_1_1,
                                    sum
                                    (
                                        case
                                            when ( trn.trantype_cd = 'TN' )
                                            then 0
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( trim( alw.allwtrans_cd ) = '2' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_2_1
                              from  camdnats.TTRANSACT trn
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                             where  cmb.accttype_cd = 'UA'
                               and  trn.sellacct_id = cmb.acctnum_id
                               and  trn.compyear_dt::integer = cmb.compyear_dt
                               and  trn.transtat_cd = 'CP'
                               and  trn.trantype_cd in ( 'TB', 'TE', 'TN' )
                            union   all
                            -- Error Correction for Takeback for Underutilization and Emissions Deduction (Overdraft)
                            select  sum
                                    (
                                        case
                                            when ( alw.allwyear_dt = cmb.compyear_dt )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as current_deduct,
                                    sum
                                    (
                                        case
                                            when ( trn.trantype_cd = 'TN' )
                                            then 0
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( trim( alw.allwtrans_cd ) = '1' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_1_1,
                                    sum
                                    (
                                        case
                                            when ( trn.trantype_cd = 'TN' )
                                            then 0
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( trim( alw.allwtrans_cd ) = '2' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_2_1
                              from  camdnats.TTRANSACT trn
                                    join camdnats.TTRANSACT cht
                                      on cht.tranevnt_cnt = trn.chgdtran_cnt
                                     and cht.compyear_dt::integer = cmb.compyear_dt
                                     and cht.transtat_cd = 'RV'
                                     and cht.trantype_cd in ( 'TB', 'TE', 'TN' )
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                             where  cmb.accttype_cd = 'UA'
                               and  trn.sellacct_id = cmb.acctnum_id
                               and  trn.transtat_cd = 'CP'
                               and  trn.trantype_cd = 'EC'
                            union   all
                            -- Compliance Problem
                            select  sum
                                    (
                                        case
                                            when ( cpt.allwyear_dt = cmb.compyear_dt )
                                            then cpt.block_total
                                            else 0
                                        end
                                    ) as current_deduct,
                                    sum
                                    (
                                        case
                                            when ( trn.trantype_cd = 'TN' )
                                            then 0
                                            when ( cpt.allwyear_dt != cmb.compyear_dt ) and ( trim( cpt.allwtrans_cd ) = '1' )
                                            then cpt.block_total
                                            else 0
                                        end
                                    ) as deduct_1_1,
                                    sum
                                    (
                                        case
                                            when ( trn.trantype_cd = 'TN' )
                                            then 0
                                            when ( cpt.allwyear_dt != cmb.compyear_dt ) and ( trim( cpt.allwtrans_cd ) = '2' )
                                            then cpt.block_total
                                            else 0
                                        end
                                    ) as deduct_2_1
                              from  camdnats.TCOMPPROB_TRANSACT cpt
                                    join camdnats.TTRANSACT trn
                                      on trn.tranevnt_cnt = cpt.tranevnt_cnt
                                     and trn.sellacct_id = cmb.acctnum_id
                                     and trn.transtat_cd = 'CP'
                             where  cmb.accttype_cd = 'UA'
                               and  cpt.compyear_dt::integer = cmb.compyear_dt
                               and  cpt.trantype_cd in ( 'TB', 'TE', 'TN' )
                            union   all
                            -- Takeback for Underutilization and Emissions Deduction (Overdraft)
                            select  sum
                                    (
                                        case
                                            when ( alw.allwyear_dt = cmb.compyear_dt )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as current_deduct,
                                    sum
                                    (
                                        case
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( coalesce( alw.allwtrans_cd, '1' ) like '1%' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_1_1,
                                    sum
                                    (
                                        case
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( coalesce( alw.allwtrans_cd, '1' ) like '2%' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_2_1
                              from  camdnats.TARS_OVDFT_DED nod
                                    join camdnats.TTRANSACT trn
                                      on trn.tranevnt_cnt = nod.tranevnt_cnt
                                     and trn.transtat_cd = 'CP'
                                     and trn.trantype_cd in ( 'TB', 'TE' )
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                             where  cmb.accttype_cd = 'OD'
                               and  ( substr( nod.acctnum_id, 1, 6 ) || 'OVERDF' ) = cmb.acctnum_id
                               and  nod.compyear_dt::integer = cmb.compyear_dt
                            union   all
                            -- Error Correction for Takeback for Underutilization and Emissions Deduction (Overdraft)
                            select  sum
                                    (
                                        case
                                            when ( alw.allwyear_dt = cmb.compyear_dt )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as current_deduct,
                                    sum
                                    (
                                        case
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( coalesce( alw.allwtrans_cd, '1' ) like '1%' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_1_1,
                                    sum
                                    (
                                        case
                                            when ( alw.allwyear_dt != cmb.compyear_dt ) and ( coalesce( alw.allwtrans_cd, '1' ) like '2%' )
                                            then ( alw.serend_cnt - alw.serstart_cnt + 1 )
                                            else 0
                                        end
                                    ) as deduct_2_1
                              from  camdnats.TARS_OVDFT_DED nod
                                    join camdnats.TTRANSACT trn
                                      on trn.tranevnt_cnt = nod.tranevnt_cnt
                                     and trn.transtat_cd = 'CP'
                                     and trn.trantype_cd = 'EC'
                                     and exists
                                         (
                                            select  1
                                              from  camdnats.TARS_OVDFT_DED xod
                                                    join camdnats.TTRANSACT xtr
                                                      on xtr.tranevnt_cnt = xod.tranevnt_cnt
                                                     and xtr.transtat_cd = 'RV'
                                                     and xtr.trantype_cd in ( 'TB', 'TE' )
                                             where  xod.compyear_dt::integer = cmb.compyear_dt
                                         )
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                             where  cmb.accttype_cd = 'OD'
                               and  ( substr( nod.acctnum_id, 1, 6 ) || 'OVERDF' ) = cmb.acctnum_id
                            union   all
                            -- Compliance Problem (Overdraft)
                            select  sum
                                    (
                                        case
                                            when ( cpt.allwyear_dt = cmb.compyear_dt )
                                            then cpt.block_total
                                            else 0
                                        end
                                    ) as current_deduct,
                                    sum
                                    (
                                        case
                                            when ( cpt.allwyear_dt != cmb.compyear_dt ) and ( trim( cpt.allwtrans_cd ) = '1' )
                                            then cpt.block_total
                                            else 0
                                        end
                                    ) as deduct_1_1,
                                    sum
                                    (
                                        case
                                            when ( cpt.allwyear_dt != cmb.compyear_dt ) and ( trim( cpt.allwtrans_cd ) = '2' )
                                            then cpt.block_total
                                            else 0
                                        end
                                    ) as deduct_2_1
                              from  camdnats.TCOMPPROB_TRANSACT cpt
                                    join camdnats.TTRANSACT trn
                                      on trn.tranevnt_cnt = cpt.tranevnt_cnt
                                     and trn.transtat_cd = 'CP'
                             where  cmb.accttype_cd = 'OD'
                               and  ( substr( cpt.acctnum_id, 1, 6 ) || 'OVERDF' ) = cmb.acctnum_id
                               and  cpt.compyear_dt::integer = cmb.compyear_dt
                               and  cpt.trantype_cd in ( 'TB', 'TE' )
                        ) sub
            ) ded
              on true
            -- Other Deductions
            left join lateral
            (
                select  sum( sub.other_deduct ) as other_deduct
                  from  (
                            select  allwdct_cnt as other_deduct
                              from  camdnats.TARS_ALLW_DED tad
                             where  cmb.accttype_cd = 'UA'
                               and  tad.acctnum_id = cmb.acctnum_id
                               and  tad.compyear_dt::integer = cmb.compyear_dt
                               and  tad.dedtype_cd = 'TB'
                            union   all
                            select  ( alw.serend_cnt - alw.serstart_cnt + 1 ) as other_deduct
                              from  camdnats.TTRANSACT trn
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                                     and alw.allwyear_dt = cmb.compyear_dt
                             where  cmb.accttype_cd = 'UA'
                               and  trn.sellacct_id = cmb.acctnum_id
                               and  trn.compyear_dt::integer = cmb.compyear_dt
                               and  trn.transtat_cd = 'CP'
                               and  trn.trantype_cd = 'TN'
                            union   all
                            select  ( alw.serend_cnt - alw.serstart_cnt + 1 ) as other_deduct
                              from  camdnats.TTRANSACT trn
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                                     and alw.allwyear_dt = cmb.compyear_dt
                             where  cmb.accttype_cd = 'UA'
                               and  trn.sellacct_id = cmb.acctnum_id
                               and  trn.transtat_cd = 'CP'
                               and  trn.trantype_cd = 'EC'
                               and  exists
                                    (
                                        select  1
                                          from  camdnats.TTRANSACT exs
                                         where  exs.tranevnt_cnt = trn.chgdtran_cnt
                                           and  exs.compyear_dt::integer = cmb.compyear_dt
                                           and  exs.transtat_cd = 'RV'
                                           and  exs.trantype_cd = 'TN'
                                    )
                        ) sub
            ) oth
              on true
            -- Excess Emissions
            left join lateral
            (
                select  sum( sub.excess_emiss ) as excess_emiss
                  from  (
                            select  allwdct_cnt as excess_emiss
                              from  camdnats.TARS_ALLW_DED tad
                             where  cmb.accttype_cd = 'UA'
                               and  tad.acctnum_id = cmb.acctnum_id
                               and  tad.compyear_dt::integer = cmb.compyear_dt
                               and  tad.dedtype_cd = 'PE'
                        ) sub
            ) exc
              on true
            -- Penalty Deduction Information
            join lateral
            (
                select  string_agg( agg.penalty_deduct_info, ', ' ) as penalty_deduct_info
                  from  (
                            select  alw.allwyear_dt,
                                    case
                                        when alw.allwyear_dt > 0
                                        then ( sum( alw.serend_cnt - alw.serstart_cnt + 1 ) || ' (' || alw.allwyear_dt || ' Allowances)' )
                                        else ( sum( alw.serend_cnt - alw.serstart_cnt + 1 ) || ' (Unknown Vintages)' )
                                    end as penalty_deduct_info
                              from  camdnats.TTRANSACT trn
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                             where  trn.sellacct_id = cmb.acctnum_id
                               and  (
                                        trn.trantype_cd = 'PE' and
                                        trn.transtat_cd = 'CP' and
                                        trn.compyear_dt::integer = cmb.compyear_dt
                                        or
                                        trn.trantype_cd = 'EC' and
                                        trn.transtat_cd = 'CP' and
                                        exists
                                        (
                                            select  1
                                              from  camdnats.TTRANSACT exs
                                             where  exs.tranevnt_cnt = trn.chgdtran_cnt
                                               and  exs.trantype_cd = 'PE'
                                               and  exs.transtat_cd = 'RV'
                                               and  exs.compyear_dt::integer = cmb.compyear_dt
                                        )
                                    )
                             group
                                by  alw.allwyear_dt
                            union   all
                            -- Overdraft Compliance Problem
                            select  cpt.allwyear_dt,
                                    case
                                        when cpt.allwyear_dt > 0
                                        then ( sum( cpt.block_total ) || ' (' || cpt.allwyear_dt || ' Allowances)' )
                                        else ( sum( cpt.block_total ) || ' (Unknown Vintages)' )
                                    end as penalty_deduct_info
                              from  camdnats.TCOMPPROB_TRANSACT cpt
                                    join camdnats.TTRANSACT trn
                                      on trn.tranevnt_cnt = cpt.tranevnt_cnt
                                     and trn.sellacct_id = cmb.acctnum_id
                                     and trn.transtat_cd = 'CP'
                             where  cmb.accttype_cd = 'UA'
                               and  cpt.compyear_dt::integer = cmb.compyear_dt
                               and  cpt.trantype_cd = 'PE'
                             group
                                by  cpt.allwyear_dt
                            union   all
                            -- Penalty Deductions and Penalty Deduction Error Correction Reversals (Overdraft)
                            select  alw.allwyear_dt,
                                    case
                                        when alw.allwyear_dt > 0
                                        then ( sum( alw.serend_cnt - alw.serstart_cnt + 1 ) || ' (' || alw.allwyear_dt || ' Allowances)' )
                                        else ( sum( alw.serend_cnt - alw.serstart_cnt + 1 ) || ' (Unknown Vintages)' )
                                    end as penalty_deduct_info
                              from  camdnats.TARS_OVDFT_DED odd
                                    join camdnats.TTRANSACT trn
                                      on trn.tranevnt_cnt = odd.tranevnt_cnt
                                     and (
                                            trn.trantype_cd = 'PE' and
                                            trn.transtat_cd = 'CP' and
                                            odd.compyear_dt::integer = cmb.compyear_dt
                                            or
                                            trn.trantype_cd = 'EC' and
                                            trn.transtat_cd = 'CP' and
                                            exists
                                            (
                                                select  1
                                                  from  camdnats.TARS_OVDFT_DED xod
                                                        join camdnats.TTRANSACT xtr
                                                          on xtr.tranevnt_cnt = xod.tranevnt_cnt
                                                         and xtr.trantype_cd = 'PE'
                                                         and xtr.transtat_cd = 'RV'
                                                 where  xod.tranevnt_cnt = trn.chgdtran_cnt
                                                   and  xod.compyear_dt::integer = cmb.compyear_dt
                                            )
                                         )
                                    join camdnats.TALLOW alw
                                      on alw.tranevnt_cnt = trn.tranevnt_cnt
                             where  cmb.accttype_cd = 'UA'
                               and  ( substr( odd.acctnum_id, 1, 6 ) || 'OVERDF' ) = cmb.acctnum_id
                               and  trn.sellacct_id = cmb.acctnum_id
                             group
                                by  alw.allwyear_dt
                            union   all
                            -- Overdraft Compliance Problem (Overdraft)
                            select  cpt.allwyear_dt,
                                    case
                                        when cpt.allwyear_dt > 0
                                        then ( sum( cpt.block_total ) || ' (' || cpt.allwyear_dt || ' Allowances)' )
                                        else ( sum( cpt.block_total ) || ' (Unknown Vintages)' )
                                    end as penalty_deduct_info
                              from  camdnats.TCOMPPROB_TRANSACT cpt
                                    join camdnats.TTRANSACT trn
                                      on trn.tranevnt_cnt = cpt.tranevnt_cnt
                                     and trn.sellacct_id = cmb.acctnum_id
                                     and trn.transtat_cd = 'CP'
                             where  cmb.accttype_cd = 'UA'
                               and  ( substr( cpt.acctnum_id, 1, 6 ) || 'OVERDF' ) = cmb.acctnum_id
                               and  cpt.compyear_dt = cmb.compyear_dt
                               and  cpt.trantype_cd = 'PE'
                             group
                                by  cpt.allwyear_dt
                        ) agg
            ) pen
              on true
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
