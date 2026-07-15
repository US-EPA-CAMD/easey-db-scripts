CREATE UNIQUE INDEX IF NOT EXISTS api_endpoint_lock_pk 
  ON camdeasey.api_endpoint_lock (api_endpoint_lock_id);
CREATE UNIQUE INDEX IF NOT EXISTS api_endpoint_lock_uq 
  ON camdeasey.api_endpoint_lock (api_endpoint_path);