#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

while getopts :u:pd opts; do
   case ${opts} in
      d) DEV="true" ;;
      u) USER="$OPTARG" ;;
      p) PASS="$OPTARG" ;;
   esac
done

if [ -z "$USER" ] || [ -z "$PASS" ] ; then
  echo "Specify an username and password."
  echo "Run the command with -u USER -p PASS"
else
  if [ -z "$DEV" ] ; then
  BACKEND_CONTAINER=backend
  else
    BACKEND_CONTAINER=backend_dev
  fi

  docker-compose stop $BACKEND_CONTAINER postgres
  docker-compose rm postgres
  docker volume rm helios-server_postgresdata

  # docker-compose exec postgres dropdb -U helios helios
  # docker-compose exec postgres createdb -U helios helios

  docker-compose up -d --no-deps postgres $BACKEND_CONTAINER
  docker-compose exec $BACKEND_CONTAINER python manage.py makemigrations
  docker-compose exec $BACKEND_CONTAINER python manage.py migrate

  USER_CMD="from helios_auth.models import User; User.objects.create(user_type='password',user_id='$USER', info={'name':'FECh', 'password': '$PASS'})"
  echo "$USER_CMD"| docker-compose exec -T $BACKEND_CONTAINER python manage.py shell
fi