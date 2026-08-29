ALTER TABLE camdmd.application
        ADD CONSTRAINT fk_application_applet_code FOREIGN KEY (applet_cd) 
            REFERENCES camdmd.applet_code (applet_cd);
ALTER TABLE camdmd.application
        ADD CONSTRAINT fk_host_status_cd FOREIGN KEY (host_status_cd) 
            REFERENCES camdmd.host_status_code (host_status_cd);

CREATE UNIQUE INDEX IF NOT EXISTS pk_app 
  ON camdmd.application (app_cd,applet_cd);