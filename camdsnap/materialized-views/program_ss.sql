create materialized view camdsnap.PROGRAM_SS 
as 
select  distinct
        prg.prg_id,
        prg.prg_cd as prg_code,
        pp.prog_phase_begin_date as begin_date,
        prg.fed_ind as fed_state_ind,
        prg.userid,
        case when noxp.required_ind is null then 'N' when noxp.required_ind = 0 then 'N' when noxp.required_ind = 1 then 'Y' end nox,
        case when so2p.required_ind is null then 'N' when so2p.required_ind = 0 then 'N' when so2p.required_ind = 1 then 'Y' end so2,
        case when co2p.required_ind is null then 'N' when co2p.required_ind = 0 then 'N' when co2p.required_ind = 1 then 'Y' end co2,
        case when hip.required_ind  is null then 'N' when hip.required_ind  = 0 then 'N' when hip.required_ind  = 1 then 'Y' end hi,
        case when hgp.required_ind  is null then 'N' when hgp.required_ind  = 0 then 'N' when hgp.required_ind  = 1 then 'Y' end hg,
        prg.add_date,
        prg.update_date,
        prg.state_cd as state,
        pp.prog_phase_end_date as end_date,
        prg.overdraft_ind as overdraft,
        prg.state_reg,
        prg.tribal_land_cd,
        prg.trading_ind,
        now() as refresh_time
  from  camd.PROGRAM  prg
        join camd.PROGRAM_PHASE pp
          on pp.prg_id = prg.prg_id
         and coalesce( pp.phase, 'Z' ) <> 'P1'
        left join camdecmpsaux.PROGRAM_PARAMETER noxp
          on noxp.prg_id = prg.prg_id
         and noxp.parameter_cd = 'NOX'
         and noxp.end_rpt_period_id is null
        left join camdecmpsaux.PROGRAM_PARAMETER so2p
          on so2p.prg_id = prg.prg_id
         and so2p.parameter_cd = 'SO2'
         and so2p.end_rpt_period_id is null
        left join camdecmpsaux.PROGRAM_PARAMETER co2p
          on co2p.prg_id = prg.prg_id
         and co2p.parameter_cd = 'CO2'
         and co2p.end_rpt_period_id is null
        left join camdecmpsaux.PROGRAM_PARAMETER hip
          on hip.prg_id = prg.prg_id
         and hip.parameter_cd = 'HI'
         and hip.end_rpt_period_id is null
        left join camdecmpsaux.PROGRAM_PARAMETER hgp
          on hgp.prg_id = prg.prg_id
         and hgp.parameter_cd = 'HG'
         and hgp.end_rpt_period_id is null;


comment on materialized view camdsnap.PROGRAM_SS is 'snapshot table for snapshot CAMDSNAP.PROGRAM_SS';
