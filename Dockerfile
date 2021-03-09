FROM python


# APP SETTINGS
ENV MLFLOW_HOME /opt/mlflow
ENV MLFLOW_VERSION 1.12.1
ENV SERVER_HOST 0.0.0.0
ENV PORT 6000
ENV FILE_STORE ${MLFLOW_HOME}/fileStore
ENV ARTIFACT_STORE ${MLFLOW_HOME}/artifactStore


# SECRETS ENV VARS LOADING
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG DB_USER_ID
ARG DB_USER_KEY
ARG DB_ENDPOINT
ARG S3_BUCKET
ARG DB_PORT
ARG DB_NAME
ARG MLFLOW_TRACKING_USERNAME
ARG MLFLOW_TRACKING_PASSWORD

ENV AWS_ACCESS_KEY_ID ${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY ${AWS_SECRET_ACCESS_KEY}
ENV DB_USER_ID ${DB_USER_ID}
ENV DB_USER_KEY ${DB_USER_KEY}
ENV DB_ENDPOINT ${DB_ENDPOINT}
ENV S3_BUCKET ${S3_BUCKET}
ENV DB_PORT ${DB_PORT}
ENV DB_NAME ${DB_NAME}

ENV MLFLOW_TRACKING_USERNAME ${MLFLOW_TRACKING_USERNAME}
ENV MLFLOW_TRACKING_PASSWORD ${MLFLOW_TRACKING_PASSWORD}

# DEP INSTALL AND FOLDER STRUCTURE SETUP
RUN pip install mlflow==${MLFLOW_VERSION} && \
    pip install boto3 && \
    pip install mysqlclient && \
    apt-get update && \
    apt-get -y install supervisor gettext-base nginx apache2-utils python3-psycopg2 && \
    mkdir -p ${MLFLOW_HOME}/scripts && \
    mkdir -p ${FILE_STORE} && \
    mkdir -p ${ARTIFACT_STORE}

RUN chmod -R 0777 ${MLFLOW_HOME}
WORKDIR ${MLFLOW_HOME}

RUN addgroup -gid 1000 www \
    && adduser -uid 1000 -H -D -s /bin/sh -G www www

COPY nginx.conf.template ${MLFLOW_HOME}/scripts/nginx.conf.template
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY scripts/entry-point.sh ${MLFLOW_HOME}/scripts/entry-point.sh
COPY scripts/webserver.sh ${MLFLOW_HOME}/scripts/webserver.sh
COPY scripts/mlflow.sh ${MLFLOW_HOME}/scripts/mlflow.sh

RUN chmod a+x ${MLFLOW_HOME}/scripts/entry-point.sh
RUN chmod a+x ${MLFLOW_HOME}/scripts/webserver.sh
RUN chmod a+x ${MLFLOW_HOME}/scripts/mlflow.sh

CMD ["/bin/bash", "./scripts/entry-point.sh"]

