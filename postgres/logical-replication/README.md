# EASEY Logical Replication Set Up Scripts 

This directory contains the scripts used to set up logical replication between a Cloud.gov EASEY Postgres database and a Postgres database in EPA's DMAP environment.  The scripts in the *cloudgov* directory are intended to be run on the publisher (Cloud.gov) and the scripts in the *dmap* directory are intended to be run on the subscriber (DMAP). 

The information to setup the scripts, subscribe to the publication, replicate to DMAP, and monitor the process can be found in the [Runbook](https://github.com/US-EPA-CAMD/easey-docs/blob/develop/CAMDRunbook.md#95-logical-replication).