#!/usr/bin/env bash

APP=$1

NS=$2

if [ "$APP" = "" ]; then
  echo "No app provided, defaulting to platform-svcs-gitops"
  APP=platform-svcs-gitops
fi

if [ "$NS" = "" ]; then
  echo "No namespace provided, defaulting to tap-install"
  NS=tap-install
fi

kctrl app kick -n $NS -a $APP -y
