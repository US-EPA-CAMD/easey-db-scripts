CREATE TABLE IF NOT EXISTS camdaux.registered_system
(
    login varchar(8) NOT NULL,
    password varchar(100) NOT NULL,
    ipaddress varchar(15) NOT NULL,
    PRIMARY KEY (login, password, ipaddress)
);
COMMENT ON TABLE camdaux.registered_system
    IS 'RGGI client database credentials for downloading facility/inventory data';
COMMENT ON COLUMN camdaux.registered_system.login
    IS 'User identifier of the RGGI database client';
COMMENT ON COLUMN camdaux.registered_system.password
    IS 'Password expected by the RGGI database client';
COMMENT ON COLUMN camdaux.registered_system.ipaddress
    IS 'IP address of the RGGI database client';