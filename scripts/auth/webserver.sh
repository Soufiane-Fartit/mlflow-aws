#!/bin/bash -x

envsubst '${PORT}' < ./scripts/nginx.conf.template > /etc/nginx/nginx.conf

htpasswd -b -c /etc/nginx/.htpasswd ${MLFLOW_TRACKING_USERNAME} ${MLFLOW_TRACKING_PASSWORD}
echo ${PORT}
exec nginx -g "daemon off;"