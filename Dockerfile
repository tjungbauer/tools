FROM registry.access.redhat.com/ubi9/ubi:latest

ARG cosign_version=2.3.0
ARG cosign_sub_version=-1
ARG rekor_version=1.3.6

LABEL maintainer="Thomas Jungbauer"


LABEL com.redhat.component="ubi9-container" \
      name="ubi9" \
      version="9.1.0"

#label for EULA
LABEL com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI"

#labels for container catalog
LABEL summary="Provides different tools for CICD pipelines (jq, cosign, rekor-cli)"

ENV container oci
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/bin/bash"]

RUN rm -rf /var/log/*
#rhbz 1609043
RUN mkdir -p /var/log/rhsm

RUN dnf install -y jq && yum clean all && rm -rf /var/cache/yum

RUN rpm -i https://github.com/sigstore/cosign/releases/download/v${cosign_version}/cosign-${cosign_version}${cosign_sub_version}.x86_64.rpm

RUN curl -O https://github.com/sigstore/rekor/releases/download/v${rekor_version}/rekor-cli-linux-amd64 > /usr/local/bin/rekor-cli && chmod 755 /usr/local/bin/rekor-cli

