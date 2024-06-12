# EASEY Logical Replication Set Up Scripts 

This directory contains the scripts used to set up logical replication between a Cloud.gov EASEY Postgres database and a Postgres database in EPA's DMAP environment.  The scripts in the *cloudgov* directory are intended to be run on the publisher (Cloud.gov) and the scripts in the *dmap* directory are intended to be run on the subscriber (DMAP). 

## Cloud.gov
The Cloud.gov scripts do the following:

- Set up a role which grants access to the tables involved in the replication
- Create a user for the DMAP database to use to subscribe to the EASEY publication
- Creates a publication for the tables that are to be replicated to DMAP
- Creates a heartbeat process that writes to a heartbeat table in the database where the replication is set up*

**See this link for more information on why the heartbeat process is needed [https://wolfman.dev/posts/pg-logical-heartbeats/](https://wolfman.dev/posts/pg-logical-heartbeats/)*

## DMAP
The DMAP script creates the subscription to the data in the Cloud.gov database with the user set up above

## Deployment
The high level steps to set up logical replication between the two databases are as follows:

- Logical replication is not enabled by default in the Cloud.gov AWS RDS databases.  To get the feature enabled, send an email to Cloud.gov support providing the information for the target database. 

>[!note]
>Note: A database restart is required to enable Logical Replication.  Coordinate with Cloud.gov support on the restart.  This will take the database offline for a period of time.

- Run the Cloud.gov scripts in the publication database
- Dump the schema objects from the Cloud.gov database (no data) 
- Restore the dump to the subscriber database in DMAP.  All of the ojects need to exist in the subscriber database prior to setting up replication. 
- Run the DMAP script in the DMAP database.  This creates the subscription to Cloud.gov.  Once the subscription is created, all of the existing data will be synced to the DMAP tables.

>[!note]
>The DMAP environment connects to the Cloud.gov through an AWS Fargate process.  This process establishes and monitors the SSH tunnel between the two environments. 
>If the SSH tunnel goes down the Fargate process automatically re-establishes it.  The Fargate process is managed by the DMAP group.