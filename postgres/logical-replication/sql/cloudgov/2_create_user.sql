--Creates the user dmap uses to connect to the easey database for replication
DROP USER IF EXISTS dmap_repl_user;
\prompt "Password for dmap_repl_user: " password
--This script requires the password to be passed as a parameter
CREATE USER dmap_repl_user PASSWORD :'password' IN ROLE easey_replication;