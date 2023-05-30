-- ORIS 880006, 3 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('MDC-CCFA3C5E351D46E58F70F02B2A29E065');

update camdecmpswks.MONITOR_SYSTEM set Sys_Type_Cd = 'OILM' where Mon_Sys_Id = 'CAMD-F0339667C5C04D06A1C49FE52CE002D1';

delete from camdecmpswks.qa_supp_data qsd where qsd.qa_supp_data_id = 'PACIFIC-C52520D849E249F288C2C7D5FB824BDD';


-- ORIS 880006, 4 for 2021 Q4
CALL camdecmpswks.revert_to_official_record('MDC-0429506754BF441F8B7FD97F2D4AA466');

delete from camdecmpswks.qa_supp_data qsd where qsd.qa_supp_data_id = 'PACIFIC-4292FAE6DA5A4FCD839E3B8F6BFDAF37';
