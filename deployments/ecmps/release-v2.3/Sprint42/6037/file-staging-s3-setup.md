# File-Staging S3 Service Setup

The Bulk Import module uses an S3 service instance named `file-staging`. Bulk
Import files are stored under the `bulk-import` path prefix so that the bucket
can support other functionality under different prefixes in the future.

The development environment already has this service. Complete the following
steps separately in each upper environment.

## 1. Create the Service and Service Key

```bash
cf create-service s3 basic-public file-staging
cf create-service-key file-staging file-staging-key
cf service-key file-staging file-staging-key
```

Check the service status 

```bash
cf service file-staging
```

Then rerun the service-key creation and retrieval commands.

- `credentials.bucket`
- `credentials.access_key_id`
- `credentials.secret_access_key`

## 2. Update the Environment Manifest Variables

In the `easey-camd-services` repository, replace the `TODO` value for
`fileStagingS3Bucket` in the file for the target environment:

| Environment | File |
| --- | --- |
| Development | `manifest-vars.yml` |
| Test | `manifest-vars.test.yml` |
| Staging | `manifest-vars.staging.yml` |
| Performance | `manifest-vars.perf.yml` |
| Beta | `manifest-vars.beta.yml` |
| Production | `manifest-vars.prod.yml` |

Set the value to `credentials.bucket` from the service-key output:

```yaml
fileStagingS3Bucket: <credentials.bucket>
```

## 3. Set the Service Credentials

Set the access key and secret key directly on `camd-services` in the same environment:

```bash
cf set-env camd-services EASEY_CAMD_SERVICES_FILE_STAGING_AWS_ACCESS_KEY_ID <credentials.access_key_id>
cf set-env camd-services EASEY_CAMD_SERVICES_FILE_STAGING_AWS_SECRET_ACCESS_KEY <credentials.secret_access_key>
```

Restage `camd-services` it so the new environment:

```bash
cf restage camd-services
```
