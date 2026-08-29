CREATE TABLE IF NOT EXISTS camdmd.menu_link
(
    menu_link_id numeric NOT NULL,
    label varchar(150),
    image varchar(150),
    action varchar(255),
    target varchar(255),
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    display_order numeric NOT NULL,
    active numeric NOT NULL,
    parent_link_id numeric,
    menu_id numeric NOT NULL,
    menu_type_cd varchar(6) NOT NULL,
    PRIMARY KEY (menu_link_id)
);
COMMENT ON TABLE camdmd.menu_link
    IS 'Stores information about menu link items.';
COMMENT ON COLUMN camdmd.menu_link.menu_link_id
    IS 'Identity key for MENU_LINK.';
COMMENT ON COLUMN camdmd.menu_link.label
    IS 'The text of the menu link item.';
COMMENT ON COLUMN camdmd.menu_link.image
    IS 'The image of the menu link item.';
COMMENT ON COLUMN camdmd.menu_link.action
    IS 'Tracks the type of action.';
COMMENT ON COLUMN camdmd.menu_link.target
    IS 'The target of the menu link item.';
COMMENT ON COLUMN camdmd.menu_link.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdmd.menu_link.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdmd.menu_link.display_order
    IS 'Column order for reports.';
COMMENT ON COLUMN camdmd.menu_link.active
    IS 'Indicator of whether the menu link item record is active.';
COMMENT ON COLUMN camdmd.menu_link.parent_link_id
    IS 'The parent menu link of the menu link item.';
COMMENT ON COLUMN camdmd.menu_link.menu_id
    IS 'Identity key for MENU.';
COMMENT ON COLUMN camdmd.menu_link.menu_type_cd
    IS 'Indicates the type of MENU.';