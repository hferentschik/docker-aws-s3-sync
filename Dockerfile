FROM python:3.8.1-alpine3.10

ENV AWSCLI_VERSION "1.16.244"
RUN apk -v --update add groff 
RUN pip install --upgrade awscli==$AWSCLI_VERSION && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="aws-s3-sync" \
      org.label-schema.description="Periodically sync a folder to Amazon S3" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/hferentschik/docker-aws-s3-sync" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
                
ENV AWSCLI_VERSION "1.16.244"
ENV KEY=,SECRET=,REGION=,BUCKET=,BUCKET_PATH=/,CRON_SCHEDULE="0 1 * * *",PARAMS=

VOLUME ["/data"]

ADD *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/start.sh"]
CMD [""]
