# Docker image for mgmt, retrieval, etl and engine servlets. It receives two
# arguments: the first is the name of the appliance this image will belong to and
# the second is the name of the appliance (mgmt, retrieval, etl or engine).

ARG BASE_VER=
FROM lnlscon/epics-archiver-base:${BASE_VER}
RUN update-ca-trust extract \
  && ln -fs /etc/pki/ca-trust/extracted/java/cacerts ${JAVA_HOME}/jre/lib/security/cacerts

# user root is required to install all needed packages
USER root

ENV APPLIANCE_BASE_JMX_PORT 9050
ENV APPLIANCE_NAME epics-archiver-appliances

ENV APPLIANCE_FOLDER /opt/${APPLIANCE_NAME}

RUN mkdir -p ${APPLIANCE_FOLDER}/all

COPY setup-appliance.sh \
     tomcat-service.sh \
     ${APPLIANCE_FOLDER}/build/scripts/

COPY configuration/context.xml ${CATALINA_HOME}/conf/context.xml

RUN mkdir ${APPLIANCE_FOLDER}/build/cert/

CMD ["sh", "-c", "${APPLIANCE_FOLDER}/build/scripts/tomcat-service.sh"]
