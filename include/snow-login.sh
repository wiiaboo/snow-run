#!/bin/bash

# This script performs login to ServiceNow, which is necessary to run background scripts

# directory with the current script
my_dir=$(dirname $0)

# include common variables and functions
source $my_dir/env.sh

# if the snow_instance env variable is not set, exit
ensure_instance_set

# Read token generated by Service-Now that it expects to be sent back together with credentials
export login_token=$(get_login_token)

if [[ -z $login_token ]]
then
  echo "Could not obtain login token to access service-now instance $snow_instance" >&2
  exit 1
fi;

# Perform actual login by sending the login form
curl https://${snow_instance}/login.do -sS -b "$SNOW_COOKIE_FILE" --data "sysparm_ck=$login_token&user_name=$snow_user&user_password=$snow_pwd&ni.nolog.user_password=true&ni.noecho.user_name=true&ni.noecho.user_password=true&screensize=1920x1080&sys_action=sysverb_login" --compressed --cookie-jar "$SNOW_COOKIE_FILE"

status=$?
if [[ $status -ne 0 ]];
then
    echo "SNOW Login not successful. curl returned $status" >&2
fi
