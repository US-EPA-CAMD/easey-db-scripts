# ECMPS Release 2.0 Database Deployment

1. Create tables
    ```
    $ ./deploy.sh <ENV> TABLES
    ```
2. Pre-Data load
    ```
    $ ./deploy.sh <ENV> PRE_DATA_LOAD
    ```
3. Informatica ETL
    - Run MP Module package (30-45 minutes)
    - Verify count diff email
    - Run QA Module package (45-60 minutes)
    - Verify count diff email
    - Run EM Module package (4-6 hours without archive data)
    - Verify count diff email
4. Post-Data load & Customizations
    ```
    $ ./deploy.sh <ENV> POST_DATA_LOAD
    ```
5. Add Constraints & Indexes
    ```
    $ ./deploy.sh <ENV> ADD_CONSTRAINTS_INDEXES
    ```
    _NOTE: This part will take 24-36 hours total and must be watched very closely as it commits in groups and the password must be provided before each group. The files in the group folders run fairly quickly (less than 10 minutes). The individual files can take 30 minutes to upwards of 4-6 hours each. If there are any errors during this step and need to stop and restart comment out the successfull commits in the script._
6. Post Deployment Cleanup
    ```
    $ ./deploy.sh <ENV> POST_DEPLOYMENT_CLEANUP
    ```

> [!note]
> `ENV` above = CDC | DEV | TEST | PERF | BETA | STG | PROD
