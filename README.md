# Database Scripts
[![GitHub](https://img.shields.io/github/license/US-EPA-CAMD/easey-db-scripts)](https://github.com/US-EPA-CAMD/devops/blob/master/LICENSE)<br>

This repo contains all creation and alteration scripts for tables, view, functions, procedures, constraints, & indexes and is the source of truth for all database objects and data loading. There is a folder for each schema which contains folders for constraints-indexes, functions, procedures, tables, & views. Each object should be scripted so that it can be executed without error and stored in the appropriate schema and folder.

The deployments folder should contain a folder for each release of each application. Each release should contain a deploy.sh bash script that provides a mechanism to run sql scripts required to apply changes to the database for the release. Each release is different and should contain scripts specific to the release and leverage the object cration and alteration scripts in the schema folders as neccessary. Each release should contain a README.md with steps/instrucitons for that release.

#### Rules and Conventions
- CREATE `<OBJECT>` IF NOT EXISTS `<name>`;
- ALTER `<OBJECT>` IF EXISTS `<name>`;
- DROP `<OBJECT>` IF EXISTS `<name>` CASCADE;
- Table scripts should create tables without constraints and/or indexes
- Function scripts should drop functions with cascade at the top of file
- View scripts should drop views with cascade at the top of file
- Add table constraint/index scripts to constraints-indexes folder following the ordering convention of parent tables before child tables

#### Environment Variables
The following environment variables must be setup on the system/machine from where the scripts will be run. They can be `user` or `system` level variables or you can create a `.env` file in the root of the project. The scripts will detect a `.env` file and source it to set the values.
- EASEY_PGPORT_`ENV` = the port used when establishing the ssh tunnel
- EASEY_PGUSER_`ENV` = database user for the environment
- EASEY_PGDB_`ENV` = database name for the environment

> [!note]
> You must setup a set of these variables for each environment where `ENV` above = CDC | DEV | TEST | PERF | BETA | STG | PROD

#### Run Deployment Script
1. Open cmd prompt and login to cloud.gov using the standard login process
   ```
   $ cf login -a api.fr.cloud.gov --sso
   ```
3. Provide temporary token and target the environment space you want to connect to
   - Use `$ cf target -s <env name>` to target any environment space
4. Run the following to establish ssh tunnel
   - Replace `<local port>` and `<dbhost>` with the proper values for the environment
   ```
   $ cf ssh ssh-tunnel -L <local port>:<dbhost>:5432
   # OR use the service connect plugin
   $ cf connect-to-service -no-client ssh-tunnel camd-pg-db
   ```   
5. From the release directory run the following...
   - ENV = CDC | DEV | TEST | PERF | BETA | STG | PROD
   - STEP = TABLES | FUNCTIONS | VIEWS | PROCEDURES | ETC... (refer to the deployment release README for specifics)
   ```
   $ ./deploy.sh <ENV> <STEP>
   ```
7. The script files to be run will be displayed on the screen and you will be prompted for the password

## License & Contributing
​
This project is licensed under the MIT License. We encourage you to read this project’s [License](https://github.com/US-EPA-CAMD/devops/blob/master/LICENSE), [Contributing Guidelines](https://github.com/US-EPA-CAMD/devops/blob/master/CONTRIBUTING.md), and [Code of Conduct](https://github.com/US-EPA-CAMD/devops/blob/master/CODE_OF_CONDUCT.md).

## Disclaimer

The United States Environmental Protection Agency (EPA) GitHub project code is provided on an "as is" basis and the user assumes responsibility for its use. EPA has relinquished control of the information and no longer has responsibility to protect the integrity , confidentiality, or availability of the information. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by EPA. The EPA seal and logo shall not be used in any manner to imply endorsement of any commercial product or activity by EPA or the United States Government.
