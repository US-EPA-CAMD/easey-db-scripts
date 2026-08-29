ALTER TABLE camdmd.menu_link
        ADD CONSTRAINT fk_menu_link_menu FOREIGN KEY (menu_id, menu_type_cd) 
            REFERENCES camdmd.menu (menu_id, menu_type_cd);

CREATE UNIQUE INDEX IF NOT EXISTS pk_menu_link 
  ON camdmd.menu_link (menu_link_id);