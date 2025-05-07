DROP FUNCTION IF EXISTS camdecmps.get_em_reporting_status(numeric, numeric, character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_em_reporting_status(
    inUnitID       numeric,      
    inRptPeriodID  numeric,      
    inPrgCode      character varying )         
    RETURNS character varying 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE
AS $BODY$
DECLARE
    lStatus         character varying := '';
    lBeginDate      DATE;
    lEndDate        DATE;
    inCalendarYear  numeric;
    inQuarter       numeric;
    lMonLocID       character varying;
    lFreqCode       character varying;
    lRetireDate     DATE;
    lAffected       INTEGER := 0;
    rec             RECORD;
BEGIN
    -- Retrieve reporting period details
    SELECT calendar_year, quarter, begin_date, end_date
      INTO inCalendarYear, inQuarter, lBeginDate, lEndDate
      FROM camdecmpsmd.reporting_period
     WHERE rpt_period_id = inRptPeriodID;

    FOR rec IN
      SELECT
           up.unit_monitor_cert_begin_date,
           up.emissions_recording_begin_date,
           ml.mon_loc_id,
           ret.retire_date,
           CASE WHEN up.class_cd IN ('NA','N','NB') THEN 0 ELSE 1 END AS affected
      FROM camd.unit_program up
      JOIN camd.program p ON up.prg_id = p.prg_id
      JOIN camd.program_phase pp ON p.prg_id = pp.prg_id
      JOIN camd.unit u ON up.unit_id = u.unit_id
      JOIN camd.plant f ON u.fac_id = f.fac_id
      LEFT JOIN camdecmps.monitor_location ml ON u.unit_id = ml.unit_id
      JOIN (
            SELECT unit_id, end_date AS retire_date
              FROM camd.unit_op_status
             WHERE op_status_cd = 'OPR'
               AND begin_date <= lEndDate
               AND (end_date IS NULL OR end_date >= lBeginDate)
           ) ret ON up.unit_id = ret.unit_id
      LEFT JOIN (
            SELECT unit_id
              FROM camd.unit_program
             WHERE prg_cd = 'OTC'
           ) otc ON up.unit_id = otc.unit_id
      LEFT JOIN (
            SELECT up2.up_id
              FROM camd.unit_exemption ue
              INNER JOIN camd.unit_program up2 ON ue.unit_id = up2.unit_id
              INNER JOIN camdmd.program_exemption pe ON up2.prg_cd = pe.prg_cd 
                                              AND ue.exemption_type_cd = pe.exemption_type_cd
             WHERE ue.begin_date <= lBeginDate
               AND (ue.end_date IS NULL OR ue.end_date >= lEndDate)
           ) upe ON up.up_id = upe.up_id
      WHERE 
         (
           (p.prg_cd = 'ARP' AND up.class_cd = pp.phase)
           OR (p.prg_cd IN ('NBP','NHNOX') AND otc.unit_id IS NOT NULL AND pp.phase = 'OTC')
           OR (p.prg_cd IN ('NBP','NHNOX') AND otc.unit_id IS NULL AND COALESCE(pp.phase, ' ') <> 'OTC')
           OR (p.prg_cd NOT IN ('NBP','NHNOX','ARP') AND pp.phase IS NULL)
         )
       AND pp.phase_monitor_cert_deadline <= lEndDate
       AND up.unit_monitor_cert_begin_date <= lEndDate
       AND (up.end_date IS NULL OR up.end_date >= lBeginDate)
       AND upe.up_id IS NULL
       AND (ret.retire_date IS NULL OR ret.retire_date >= lBeginDate)
       AND up.unit_id = inUnitID
       AND up.prg_cd = COALESCE(inPrgCode, up.prg_cd)
    LOOP
       IF lMonLocID IS NULL THEN
           lMonLocID := rec.mon_loc_id;
       END IF;
       IF lRetireDate IS NULL THEN
           lRetireDate := rec.retire_date;
       END IF;

       IF rec.affected = 1 THEN
           lAffected := 1;
       END IF;

       IF (rec.emissions_recording_begin_date IS NOT NULL AND rec.emissions_recording_begin_date <= lEndDate)
          OR (rec.emissions_recording_begin_date IS NULL AND rec.unit_monitor_cert_begin_date + 180 <= lEndDate)
       THEN
           lStatus := 'REQUIRE';
           IF lAffected = 1 THEN
              EXIT;
           END IF;
       ELSE
           IF rec.emissions_recording_begin_date IS NULL THEN
              lStatus := 'GRANTED';
           END IF;
       END IF;
    END LOOP;

    IF lStatus IS NOT NULL AND lStatus <> '' THEN
       IF lMonLocID IS NULL THEN
          lStatus := 'Missing Monitor Location';
       ELSE
          BEGIN
             SELECT mp.mon_plan_id
               INTO lStatus
               FROM camdecmps.monitor_plan_location mpl
               JOIN camdecmps.monitor_plan mp ON mpl.mon_plan_id = mp.mon_plan_id
               JOIN camdecmpsmd.reporting_period brp ON mp.begin_rpt_period_id = brp.rpt_period_id
               LEFT JOIN camdecmpsmdreporting_period erp ON mp.end_rpt_period_id = erp.rpt_period_id
              WHERE (brp.calendar_year < inCalendarYear OR (brp.calendar_year = inCalendarYear AND brp.quarter <= inQuarter))
                AND (erp.calendar_year IS NULL OR erp.calendar_year > inCalendarYear OR (erp.calendar_year = inCalendarYear AND erp.quarter >= inQuarter))
                AND mpl.mon_loc_id = lMonLocID;

             IF inQuarter <> 3 THEN
                BEGIN
                   SELECT DISTINCT report_freq_cd
                     INTO lFreqCode
                     FROM camdecmps.monitor_plan_reporting_freq mprf
                     JOIN camdecmpsmd.reporting_period brp ON mprf.begin_rpt_period_id = brp.rpt_period_id
                     LEFT JOIN camdecmpsmd.reporting_period erp ON mprf.end_rpt_period_id = erp.rpt_period_id
                    WHERE (brp.calendar_year < inCalendarYear OR (brp.calendar_year = inCalendarYear AND brp.quarter <= inQuarter))
                      AND (erp.calendar_year IS NULL OR erp.calendar_year > inCalendarYear OR (erp.calendar_year = inCalendarYear AND erp.quarter >= inQuarter))
                      AND mprf.mon_plan_id = lStatus;

                   IF inQuarter = 1 OR inQuarter = 4 THEN
                      IF lFreqCode = 'OS' THEN
                         lStatus := '';
                      END IF;
                   ELSE
                      IF lFreqCode = 'OS'
                         AND lRetireDate IS NOT NULL
                         AND EXTRACT(YEAR FROM lRetireDate) = inCalendarYear
                         AND EXTRACT(MONTH FROM lRetireDate) = 4
                      THEN
                         lStatus := '';
                      END IF;
                   END IF;
                EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                      lStatus := 'Missing Reporting Frequency';
                   WHEN TOO_MANY_ROWS THEN
                      lStatus := 'Multiple Reporting Frequencies';
                   WHEN OTHERS THEN
                      lStatus := 'Postgresql error: ' || SQLERRM;
                END;
             END IF;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN
                IF lAffected = 0 THEN
                   lStatus := '';
                ELSE
                   lStatus := 'No Active Monitoring Plan';
                END IF;
             WHEN TOO_MANY_ROWS THEN
                lStatus := 'Multiple Monitoring Plans';
             WHEN OTHERS THEN
                lStatus := 'Postgresql error: ' || SQLERRM;
          END;
       END IF;
    END IF;

    RETURN lStatus;
EXCEPTION
   WHEN OTHERS THEN
      RETURN 'Postgresql error: ' || SQLERRM;
END;
$BODY$;
