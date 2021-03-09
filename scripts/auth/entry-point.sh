#!/bin/bash

export MLFLOW_TRACKING_USERNAME=$MLFLOW_TRACKING_USERNAME
export MLFLOW_TRACKING_PASSWORD=$MLFLOW_TRACKING_PASSWORD


if [[ -z "${MLFLOW_TRACKING_USERNAME}" ]]; then
    echo "Error: MLFLOW_TRACKING_USERNAME not set"
    exit 1  
fi

if [[ -z "${MLFLOW_TRACKING_PASSWORD}" ]]; then
    echo "Error: MLFLOW_TRACKING_PASSWORD not set"
    exit 1  
fi


exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf