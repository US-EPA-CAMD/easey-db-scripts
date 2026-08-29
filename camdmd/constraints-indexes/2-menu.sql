ALTER TABLE camdmd.menu
        ADD CONSTRAINT fk_menu_app_cd FOREIGN KEY (app_cd) 
            REFERENCES camdmd.application_code (app_cd);
ALTER TABLE camdmd.menu
        ADD CONSTRAINT fk_menu_menu_type FOREIGN KEY (menu_type_cd) 
            REFERENCES camdmd.menu_type (menu_type_cd);

CREATE UNIQUE INDEX IF NOT EXISTS pk_menu 
  ON camdmd.menu (menu_id,menu_type_cd);