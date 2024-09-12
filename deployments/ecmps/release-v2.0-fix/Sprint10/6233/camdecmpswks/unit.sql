--This is to copy initial data from camd.unit to camdecmpswks.unit

INSERT INTO camdecmpswks.unit (unit_id, non_load_based_ind, userid, add_date, update_date)
SELECT
    unit_id,
    non_load_based_ind,
    userid,
    add_date,
    update_date
FROM camd.unit