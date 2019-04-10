# README #

This repository contains files to run script in docker container, from the container connect to postgres databases, create backup of them, compress with gzip and copy compresses backup of databases to AWS S3 bucket.

## Before setup

_**Place all files in one directory**_

You have to enter data in env.list, in particular:

_**Postgres credentials**_
  * PG_HOST=HOST IP
  * PG_USER=user (normally, postgres)  
  * PGPASSWORD=password
  * PG_PORT=PORT id (normally 5432)


_**List of postgres databases for backup, by comma separated**_
  * PG_DATABASES=test2,another_test (for example)

_**AWS credentials**_
  * AWS_ACCESS_KEY_ID=your_access_key_id
  * AWS_SECRET_ACCESS_KEY=your_secret_access_key
  * AWS_REGION=your_aws_region

_**Bucket and path within S3**_
  * S3_PATH=my_bucket/my_directory


  ## Build docker image

  In terminal run the following command inside the directory with files:

  *docker build -t postgres_image .*

  ## Create docker container
  *docker run -ti --rm --env-file env.list postgres_image*

  Script will be run in container, container will be destroyed after script's execution
