ARG SONAR_SCANNER_VERSION=3.1.0.1141
FROM openjdk:8u201-jdk-alpine3.9
ARG SONAR_SCANNER_VERSION=3.1.0.1141
ENV SONAR_SCANNER_DEBUG_OPTS=" -Dsonar.verbose=true"
ENV RUN_BEFORE_SCAN=""
WORKDIR /usr/src/sonar-scanner/
ADD http://central.maven.org/maven2/org/sonarsource/scanner/cli/sonar-scanner-cli/${SONAR_SCANNER_VERSION}/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.jar ./sonar-scanner-cli.jar

WORKDIR /app
RUN echo -e '#!/bin/sh\n\
set -euxo pipefail \n\
eval "$RUN_BEFORE_SCAN"\n\
java \
 -classpath /usr/src/sonar-scanner/sonar-scanner-cli.jar \
 $SONAR_SCANNER_OPTS \
 $SONAR_SCANNER_DEBUG_OPTS \
 org.sonarsource.scanner.cli.Main \
 -Djava.awt.headless=true \
 -Dscanner.home=/usr/src/sonar-scanner \
 -Dsonar.host.url=$SONAR_URL \
 -Dsonar.issuesReport.console.enable=true \
 -Dsonar.login=$SONAR_TOKEN \
 -Dproject.home=/app \
 $@ -X'\
> /usr/src/sonar-scanner/sonar-scanner && \
chmod +x /usr/src/sonar-scanner/sonar-scanner && \
mkdir -p /empty.sonar.java.binaries

ENTRYPOINT /usr/src/sonar-scanner/sonar-scanner
