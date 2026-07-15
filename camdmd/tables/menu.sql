CREATE TABLE IF NOT EXISTS camdmd.menu
(
    menu_id numeric NOT NULL,
    menu_type_cd varchar(6) NOT NULL,
    menu_name varchar(60),
    top_offset numeric,
    left_offset numeric,
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    font_face varchar(60),
    font_color varchar(10),
    font_parent_size numeric,
    font_child_size numeric,
    font_rollover_color varchar(10),
    image_up_path varchar(80),
    image_down_path varchar(80),
    active numeric,
    app_cd varchar(3),
    image_up_width numeric,
    image_up_height numeric,
    menu_width numeric,
    PRIMARY KEY (menu_id, menu_type_cd)
);
COMMENT ON TABLE camdmd.menu
    IS 'Stores information about application menus.';
COMMENT ON COLUMN camdmd.menu.menu_id
    IS 'Identity key for MENU.';
COMMENT ON COLUMN camdmd.menu.menu_type_cd
    IS 'Indicates the type of MENU.';
COMMENT ON COLUMN camdmd.menu.menu_name
    IS 'The name of the MENU.';
COMMENT ON COLUMN camdmd.menu.top_offset
    IS 'For HTML menus; the distance from the top of the container in which the menu resides.';
COMMENT ON COLUMN camdmd.menu.left_offset
    IS 'For HTML menus; The distance from the left of the container in which the menu resides.';
COMMENT ON COLUMN camdmd.menu.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camdmd.menu.update_date
    IS 'Date of the last record update.';
COMMENT ON COLUMN camdmd.menu.font_face
    IS 'The font the menu uses.';
COMMENT ON COLUMN camdmd.menu.font_color
    IS 'The color of the font.';
COMMENT ON COLUMN camdmd.menu.font_parent_size
    IS 'The font of parent items in the menu.';
COMMENT ON COLUMN camdmd.menu.font_child_size
    IS 'The font of child items in the menu.';
COMMENT ON COLUMN camdmd.menu.font_rollover_color
    IS 'The font color used when the mouse is over the menu.';
COMMENT ON COLUMN camdmd.menu.image_up_path
    IS 'The image that should be shown when the menu has not been clicked.';
COMMENT ON COLUMN camdmd.menu.image_down_path
    IS 'The image that should be shown when the menu has been clicked.';
COMMENT ON COLUMN camdmd.menu.active
    IS 'Indicator of whether the menu link item record is active.';
COMMENT ON COLUMN camdmd.menu.app_cd
    IS 'Short abbreviation for APPLICATION name.';
COMMENT ON COLUMN camdmd.menu.image_up_width
    IS 'The width of the up image.';
COMMENT ON COLUMN camdmd.menu.image_up_height
    IS 'The height of the image to be displayed.';
COMMENT ON COLUMN camdmd.menu.menu_width
    IS 'The width of the MENU.';