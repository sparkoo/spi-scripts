FROM registry.access.redhat.com/ubi8/ubi-minimal:8.6-941 as spi-operator

WORKDIR /

# Install the 'shadow-utils' which contains `adduser` and `groupadd` binaries
RUN microdnf install shadow-utils \
	&& groupadd --gid 65532 nonroot \
	&& adduser \
		--no-create-home \
		--no-user-group \
		--uid 65532 \
		--gid 65532 \
		nonroot

COPY bin/operator .

USER 65532:65532

ENTRYPOINT ["/operator"]

# Compose the final image of spi-oauth service
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.6-941 as spi-oauth

WORKDIR /

# Install the 'shadow-utils' which contains `adduser` and `groupadd` binaries
RUN microdnf install shadow-utils \
	&& groupadd --gid 65532 nonroot \
	&& adduser \
		--no-create-home \
		--no-user-group \
		--uid 65532 \
		--gid 65532 \
		nonroot

COPY bin/oauth /spi-oauth
COPY static/callback_success.html /static/callback_success.html
COPY static/callback_error.html /static/callback_error.html
COPY static/redirect_notice.html /static/redirect_notice.html

USER 65532:65532

ENTRYPOINT ["/spi-oauth"]
