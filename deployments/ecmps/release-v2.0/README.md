# ECMPS Release 2.0 Database Deployment

1. Create tables
  `$ ./deploy.sh <ENV> TABLES`
2. Pre-Data load
  `$ ./deploy.sh <ENV> PRE_DATA_LOAD`
3. Informatica ETL
  - Run MP Module package (30-45 minutes)
  - Verify count diff email
  - Run QA Module package (45-60 minutes)
  - Verify count diff email
  - Run EM Module package (4-6 hours without archive data)
  - Verify count diff email
4. Post-Data load & Customizations
  `$ ./deploy.sh <ENV> POST_DATA_LOAD`
5. Add Constraints & Indexes
  `$ ./deploy.sh <ENV> ADD_CONSTRAINTS_INDEXES`
6. Post Deployment Cleanup
  `$ ./deploy.sh <ENV> POST_DEPLOYMENT_CLEANUP`

NOTE: `<ENV` can be CDC | DEV | STG | TEST | BETA | PERF | PROD
