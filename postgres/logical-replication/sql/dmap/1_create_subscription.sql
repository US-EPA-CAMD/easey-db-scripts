DROP SUBSCRIPTION IF EXISTS easey_subscription;
--Takes the connection info as a command line parameter in the form:
--'host=192.168.1.50 port=5432 user=foo dbname=foodb'
\prompt "Connection informaiton in the form 'host=192.168.1.50 port=5432 user=foo dbname=foodb': " connection
CREATE SUBSCRIPTION easey_subscription CONNECTION :"connection" PUBLICATION easey_publication;