FROM public.ecr.aws/docker/library/alpine:3.18

ENV POSTGRES_DATABASE="**None**" \
    POSTGRES_HOST="**None**" \
    POSTGRES_PORT="5432" \
    POSTGRES_USER="**None**" \
    POSTGRES_PASSWORD="**None**" \
    POSTGRES_EXTRA_OPTS="" \
    S3_ACCESS_KEY_ID="**None**" \
    S3_SECRET_ACCESS_KEY="**None**" \
    S3_BUCKET="**None**" \
    S3_PREFIX="backup" \
    S3_ENDPOINT="**None**" \
    S3_REGION="us-east-1" \
    S3_S3V4="yes" \
    ENCRYPTION_PASSWORD="**None**" \
    DELETE_OLDER_THAN="**None**"

# hadolint ignore=DL3018,DL3059
RUN apk add --no-cache catatonit coreutils aws-cli openssl
# hadolint ignore=DL3018,DL3059
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main postgresql16-client

COPY scripts/*.sh /usr/local/bin/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
