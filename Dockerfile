FROM python:3.6-alpine

MAINTAINER steranin

RUN apk add --update build-base libffi libffi-dev openssl openssl-dev && \
    pip install warcprox==2.0.1 && \
    apk del build-base libffi-dev openssl-dev

EXPOSE 8888

VOLUME ["/warcs", "/db", "/ca"]

#ENTRYPOINT ["warcprox", "--address", "0.0.0.0", "--port", "8888"]

CMD warcprox --rethinkdb-servers localhost:28015 --rethinkdb-db brozzler --rethinkdb-big-table -p 8888 -b 0.0.0.0 --base32 -z --rollover-idle-time 3600 2>&1 | tee /logs
