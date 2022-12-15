UPDATE camdmd.program_code SET bulk_file_active = 0
WHERE prg_cd IN (
  'CAIRNOX',
  'CAIROS',
  'CAIRSO2',
  'NBP',
  'OTC'
);