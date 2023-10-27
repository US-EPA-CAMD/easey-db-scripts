# CAMPD Release 1.1 Database Deployment

1. Pre-Deployment
    ```
    $ ./deploy.sh <ENV> PRE_DEPLOYMENT
    ```
2. Deploy application code to cloud.gov
3. Run Bulk Data Files process to generate all past & current bulk files and load to S3
4. After Bulk File Load
    ```
    $ ./deploy.sh <ENV> AFTER_BULK_FILE_LOAD
    ```
5. Post-Deployment
    ```
    $ ./deploy.sh <ENV> POST_DEPLOYMENT
    ```

_NOTE: `<ENV` can be CDC | DEV | STG | TEST | BETA | PERF | PROD_