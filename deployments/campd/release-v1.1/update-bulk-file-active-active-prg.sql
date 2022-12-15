ALTER TABLE IF EXISTS camdmd.program_code
  ADD COLUMN IF NOT EXISTS bulk_file_active numeric(1,0) NOT NULL DEFAULT 0;

UPDATE camdmd.program_code SET bulk_file_active = 1
WHERE prg_cd IN (
  'ARP',
  'CAIRNOX',
  'CAIROS',
  'CAIRSO2',
  'CSNOX',
  'CSNOXOS',
  'CSOSG1',
  'CSOSG2',
  'CSOSG3',
  'CSSO2G1',
  'CSSO2G2',
  'NBP',
  'OTC',
  'TXSO2'
);