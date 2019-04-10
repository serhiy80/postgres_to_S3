#!/bin/bash
############

# Check of postgres credentials
if [[ -z $PG_HOST ]]
then
	echo "PG_HOST wasn't set"
       	exit 1
fi
if [[ -z $PG_USER ]]
then
	echo "PG_USER wasn't set"
       	exit 1
fi
if [[ -z $PG_PORT ]]
then
	echo "PG_PORT wasn't set"
       	exit 1
fi

# List of databases to backup
echo "List of databases for backup -> $PG_DATABASES"

# Vars
NOW=$(date +"%Y-%m-%d-at-%H-%M-%S")

# Split databases
IFS=',' read -ra DBS <<< "$PG_DATABASES"

# Loop thru databases
for db in "${DBS[@]}"; do
    FILENAME="$NOW"_"$db"


    echo "   -> backing up $db..."
    # Dump database and compress the backup
    pg_dump -Fc -h $PG_HOST -U $PG_USER $db | gzip > /tmp/"$FILENAME".dump.gz

    # Log
    echo "      ...database $db has been backed up"
done

  #Check if files are existing
  echo "The following backup files have been created:"
  ls -la /tmp/*.dump.gz

  # Copy to S3
  # aws s3 cp /tmp/*.dump.gz s3://$S3_PATH/