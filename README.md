# docker-sonar-scanner

https://hub.docker.com/r/hasnat/sonar-scanner

Example run
```
docker run --rm \
 -w /app/ \
 -v `pwd`:/app \
 -e RUN_BEFORE_SCAN="apk add --no-cache python-dev libc-dev libffi-dev openssl-dev gcc make py-pip && pip install ansible-lint" \
 -e SONAR_SCANNER_OPTS="-Dsonar.sources=. -Dsonar.java.binaries=/empty.sonar.java.binaries" \
 -e SONAR_URL=https://sonar.yourdomain.com \
 -e SONAR_TOKEN=******** \
 hasnat/sonar-scanner
```
here `RUN_BEFORE_SCAN` is installing ansible-lint on runtime.


Available environment variables
-------------------------------
- `RUN_BEFORE_SCAN`          any command you'd want to run before sonar scanner (on alpine:3.9) e.g. apk add --no-cache node
- `SONAR_URL`                sonar URL - required ( `-Dsonar.host.url` )
- `SONAR_TOKEN`              sonar login token - required ( `-Dsonar.login` )
- `SONAR_SCANNER_OPTS`       any sonar options
- `SONAR_SCANNER_DEBUG_OPTS` any sonar debug options - optional ( `-Dsonar.verbose=true` )
