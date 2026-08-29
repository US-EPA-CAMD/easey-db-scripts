CREATE TABLE IF NOT EXISTS camdmd.menu_type
(
    menu_type_cd varchar(6) NOT NULL,
    description varchar(400),
    PRIMARY KEY (menu_type_cd)
);
COMMENT ON TABLE camdmd.menu_type
    IS 'Stores information about menu types.';
COMMENT ON COLUMN camdmd.menu_type.menu_type_cd
    IS 'Indicates the type of MENU.';
COMMENT ON COLUMN camdmd.menu_type.description
    IS 'Text description of object.';