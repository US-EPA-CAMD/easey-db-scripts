Run the following commands to create the S3 backup bucket and bind it to the ssh-tunnel app:

```
cf create-service s3 basic-public backups
cf bind-service ssh-tunnel backups -c '{"additional_instances": ["mats-bulk-files-import"]}'
```
