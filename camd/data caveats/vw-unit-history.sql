SET DEFINE OFF;

--DROP MATERIALIZED VIEW UNIT_HISTORY_SS;
--
-- UNIT_HISTORY_SS  (Materialized View) 
--
--  Dependencies: 
--   FACILITY (Synonym)
--   ACCOUNT_UNIT (Synonym)
--   UNIT_PHYSICAL_MOVE (Synonym)
--   UNIT_ALIAS (Synonym)
--   UNIT_LOGICAL_MOVE (Synonym)
--   UNIT (Synonym)
--
CREATE MATERIALIZED VIEW UNIT_HISTORY_SS 
BUILD IMMEDIATE
REFRESH FORCE ON DEMAND
WITH PRIMARY KEY
AS 
SELECT "UNIT_HISTORY"."UNIT_ID"              "UNIT_ID",
       "UNIT_HISTORY"."EFFECTIVE_DATE"       "EFFECTIVE_DATE",
       "UNIT_HISTORY"."OLD_UNITID"           "OLD_UNITID",
       "UNIT_HISTORY"."NEW_UNITID"           "NEW_UNITID",
       "UNIT_HISTORY"."OLD_ORIS_CODE"        "OLD_ORIS_CODE",
       "UNIT_HISTORY"."NEW_ORIS_CODE"        "NEW_ORIS_CODE",
       "UNIT_HISTORY"."OLD_FAC_ID"           "OLD_FAC_ID",
       "UNIT_HISTORY"."NEW_FAC_ID"           "NEW_FAC_ID",
       "UNIT_HISTORY"."UNIT_HISTORY_TYPE_CD" "UNIT_HISTORY_TYPE_CD",
       "UNIT_HISTORY"."UNIT_HISTORY_COMMENT" "UNIT_HISTORY_COMMENT",
       "UNIT_HISTORY"."USERID"               "USERID",
       "UNIT_HISTORY"."ADD_DATE"             "ADD_DATE",
       "UNIT_HISTORY"."UPDATE_DATE"          "UPDATE_DATE",
       "UNIT_HISTORY"."OLD_ACCOUNT_NUMBER"   "OLD_ACCOUNT_NUMBER",
       "UNIT_HISTORY"."NEW_ACCOUNT_NUMBER"   "NEW_ACCOUNT_NUMBER"
  FROM (SELECT UA.USERID,
               UA.ADD_DATE,
               NULL          UPDATE_DATE,
               UA.UNIT_ID,
               UA.ALIAS_DATE EFFECTIVE_DATE,
               UA.OLD_UNITID,
               U.UNITID      NEW_UNITID,
               F.ORIS_CODE   OLD_ORIS_CODE,
               F.ORIS_CODE   NEW_ORIS_CODE,
               U.FAC_ID      OLD_FAC_ID,
               U.FAC_ID      NEW_FAC_ID,
               'ALIAS'       UNIT_HISTORY_TYPE_CD,
               'Unit ID change from ' || UA.OLD_UNITID || ' to ' || U.UNITID
                   UNIT_HISTORY_COMMENT,
               NULL          NEW_ACCOUNT_NUMBER,
               NULL          OLD_ACCOUNT_NUMBER
          FROM UNIT_ALIAS UA, FACILITY F, UNIT U
         WHERE UA.UNIT_ID = U.UNIT_ID AND F.FAC_ID = U.FAC_ID
        UNION ALL
        SELECT UL.USERID,
               UL.ADD_DATE,
               UL.UPDATE_DATE,
               UL.UNIT_ID,
               UL.EFFECTIVE_DATE,
               UL.OLD_UNITID,
               U.UNITID          NEW_UNITID,
               F.ORIS_CODE       OLD_ORIS_CODE,
               NF.ORIS_CODE      NEW_ORIS_CODE,
               UL.OLD_FAC_ID,
               U.FAC_ID          NEW_FAC_ID,
               'LOGICAL'         UNIT_HISTORY_TYPE_CD,
                  'ORIS '
               || NF.ORIS_CODE
               || ' Unit '
               || U.UNITID
               || ' (previously ORIS '
               || F.ORIS_CODE
               || ' Unit '
               || UL.OLD_UNITID
               || ') '
               || U.UNIT_DESCRIPTION
                   UNIT_HISTORY_COMMENT,
               --DECODE(NA.ACCOUNT_NUMBER,NULL,TRIM(TO_CHAR(NF.ORIS_CODE,'000000')||LPAD(REPLACE(U.UNITID,'-','Z'),6,'0')),NA.ACCOUNT_NUMBER) NEW_ACCOUNT_NUMBER,
               NA.ACCOUNT_NUMBER NEW_ACCOUNT_NUMBER,
               TRIM (TO_CHAR (F.ORIS_CODE, '000000')
                    || LPAD (REPLACE (UL.OLD_UNITID, '-', 'Z'),6,'0')) OLD_ACCOUNT_NUMBER
          FROM UNIT_LOGICAL_MOVE  UL
               JOIN UNIT U ON UL.UNIT_ID = U.UNIT_ID
               JOIN FACILITY F ON UL.OLD_FAC_ID = F.FAC_ID
               LEFT OUTER JOIN ACCOUNT_UNIT NA ON U.UNIT_ID = NA.UNIT_ID
               JOIN FACILITY NF ON U.FAC_ID = NF.FAC_ID
               --LEFT OUTER JOIN ACCOUNT_UNIT OA ON UL.UNIT_ID = OA.UNIT_ID
        UNION ALL
        SELECT UP.USERID,
               UP.ADD_DATE,
               UP.UPDATE_DATE,
               UP.UNIT_ID,
               UP.EFFECTIVE_DATE,
               U.UNITID          OLD_UNITID,
               NU.UNITID         NEW_UNITID,
               F.ORIS_CODE       OLD_ORIS_CODE,
               NF.ORIS_CODE      NEW_ORIS_CODE,
               U.FAC_ID          OLD_FAC_ID,
               NU.FAC_ID         NEW_FAC_ID,
               'PHYSCAL'         UNIT_HISTORY_TYPE_CD,
                  'ORIS '
               || NF.ORIS_CODE
               || ' Unit '
               || NU.UNITID
               || ' (previously ORIS '
               || F.ORIS_CODE
               || ' Unit '
               || U.UNITID
               || ') '
               || NU.UNIT_DESCRIPTION
                   UNIT_HISTORY_COMMENT,
               NULL              NEW_ACCOUNT_NUMBER,
               OA.ACCOUNT_NUMBER OLD_ACCOUNT_NUMBER
          --DECODE(NA.ACCOUNT_NUMBER,NULL,TRIM(TO_CHAR(NF.ORIS_CODE,'000000')||LPAD(REPLACE(NU.UNITID,'-','Z'),6,'0')),NA.ACCOUNT_NUMBER) NEW_ACCOUNT_NUMBER,
          --DECODE(OA.ACCOUNT_NUMBER,NULL,TRIM(TO_CHAR(F.ORIS_CODE,'000000')||LPAD(REPLACE(U.UNITID,'-','Z'),6,'0')),OA.ACCOUNT_NUMBER) OLD_ACCOUNT_NUMBER
          FROM UNIT_PHYSICAL_MOVE  UP
               JOIN UNIT U ON UP.UNIT_ID = U.UNIT_ID
               JOIN UNIT NU ON UP.NEW_UNIT_ID = NU.UNIT_ID
               JOIN FACILITY F ON U.FAC_ID = F.FAC_ID
               LEFT OUTER JOIN ACCOUNT_UNIT NA ON NU.UNIT_ID = NA.UNIT_ID
               JOIN FACILITY NF ON NU.FAC_ID = NF.FAC_ID
               LEFT OUTER JOIN ACCOUNT_UNIT OA ON U.UNIT_ID = OA.UNIT_ID)
       UNIT_HISTORY
/

COMMENT ON MATERIALIZED VIEW UNIT_HISTORY_SS IS 'snapshot table for snapshot CAMDSNAP.UNIT_HISTORY_SS'
/

--
-- PK_UNIT_HISTORY  (Index) 
--
--  Dependencies: 
--   UNIT_HISTORY_SS (Table)
--   UNIT_HISTORY_SS (Materialized View)
--
CREATE UNIQUE INDEX PK_UNIT_HISTORY ON UNIT_HISTORY_SS
(UNIT_ID, EFFECTIVE_DATE)
/

--
-- UH_IDX_NEW_ACCT_NUM  (Index) 
--
--  Dependencies: 
--   UNIT_HISTORY_SS (Table)
--   UNIT_HISTORY_SS (Materialized View)
--
CREATE INDEX UH_IDX_NEW_ACCT_NUM ON UNIT_HISTORY_SS
(NEW_ACCOUNT_NUMBER)
/

--
-- UH_IDX_NEW_FAC_ID  (Index) 
--
--  Dependencies: 
--   UNIT_HISTORY_SS (Table)
--   UNIT_HISTORY_SS (Materialized View)
--
CREATE INDEX UH_IDX_NEW_FAC_ID ON UNIT_HISTORY_SS
(NEW_FAC_ID)
/

--
-- UH_IDX_OLD_ACCT_NUM  (Index) 
--
--  Dependencies: 
--   UNIT_HISTORY_SS (Table)
--   UNIT_HISTORY_SS (Materialized View)
--
CREATE INDEX UH_IDX_OLD_ACCT_NUM ON UNIT_HISTORY_SS
(OLD_ACCOUNT_NUMBER)
/

--
-- UH_IDX_OLD_FAC_ID  (Index) 
--
--  Dependencies: 
--   UNIT_HISTORY_SS (Table)
--   UNIT_HISTORY_SS (Materialized View)
--
CREATE INDEX UH_IDX_OLD_FAC_ID ON UNIT_HISTORY_SS
(OLD_FAC_ID)
/
