#!/bin/bash

envpart="/tmp/envpart"
rm -f $envpart
touch $envpart

confirm() {
  echo $@
  read -p "[Y/n] " answer
  case "$answer" in
    N*|n*)
      false
      ;;
    Y*|y*)
      true
      ;;
  esac
}

writeline() {
  val=`eval echo \\\$$1`
  echo "$1=$val" >> $envpart
  echo "$1=$val"
}

if [[ -z "$DJANGO_SETTINGS_MODULE" ]]; then
  echo "DJANGO_SETTINGS_MODULE: enter the dot notation path to the settings file you want to use, e.g. 'app.settings.local'"
  read -p "> " DJANGO_SETTINGS_MODULE
fi
writeline DJANGO_SETTINGS_MODULE

echo -e "SECRET_KEY=HiI'mnotarealsecretDjangokey" >> $envpart
echo -e "DEBUG=False" >> $envpart

if [[ -z "$CONTAINER" ]]; then
  echo "CONTAINER: name of your Docker container, e.g. 'postgres'"
  read -p "> " CONTAINER
fi
writeline CONTAINER

if [[ -z "$POSTGRES_DB" ]]; then
  echo "POSTGRES_DB: name of your Postgres database, e.g. 'pgdb'"
  read -p "> " POSTGRES_DB
fi
writeline POSTGRES_DB

if [[ -z "$POSTGRES_USER" ]]; then
  echo "POSTGRES_USER: name of your Postgres database, e.g. 'pgdb_user'"
  read -p "> " POSTGRES_USER
fi
writeline POSTGRES_USER

if [[ -z "$POSTGRES_PASSWORD" ]]; then
  echo "POSTGRES_PASSWORD: name of your Postgres database, e.g. 'pgdb_pass'"
  read -p "> " POSTGRES_PASSWORD
fi
writeline POSTGRES_PASSWORD

echo -e "POSTGRES_HOST=127.0.0.1" >> $envpart
echo -e "POSTGRES_PORT=5432" >> $envpart

echo
echo "Here are your settings:"
echo
printf "%b\n" `cat $envpart`
echo

if confirm "Do you want to write these settings to .env? This will overwrite the file."; then
  if [[ -f .env ]]; then
    mv .env .env-`date +%F-%T`
    echo "Backed up exising envpart file."
  fi
    mv $envpart .env
    echo "New .env file written!"
fi
