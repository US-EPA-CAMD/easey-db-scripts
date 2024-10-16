--This is to copy initial data from camd.unit to camdecmpswks.unit

INSERT INTO camdecmpswks.unit (fac_id, unit_id, unitid, non_load_based_ind, userid, add_date, update_date)
SELECT
    fac_id, 
    unit_id,
    unitid,
    non_load_based_ind,
    userid,
    add_date,
    update_date
FROM camd.unit