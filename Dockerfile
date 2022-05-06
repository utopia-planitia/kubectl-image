FROM ubuntu:22.04
SHELL [ "/bin/bash", "-euxo", "pipefail", "-c" ]

# hadolint ignore=DL3008
RUN apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        gettext-base \
        git \
        jq \
        netcat \
        ; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

ENV MINIO_VERSION=RELEASE.2022-04-26T18-00-22Z
RUN KERNEL="$(uname --kernel-name | tr '[:upper:]' '[:lower:]')"; \
    ARCH="$(uname --machine | sed --expression='s/aarch64/arm64/' --expression='s/x86_64/amd64/')"; \
    curl --fail --location --output /usr/local/bin/mc "https://dl.min.io/client/mc/release/${KERNEL:?}-${ARCH:?}/archive/mc.${MINIO_VERSION:?}"; \
    chmod +x /usr/local/bin/mc; \
    command -v mc; \
    mc --version | grep --fixed-strings "${MINIO_VERSION:?}"

ENV KUBECTL_VERSION=v1.23.6
RUN KERNEL="$(uname --kernel-name | tr '[:upper:]' '[:lower:]')"; \
    ARCH="$(uname --machine | sed --expression='s/aarch64/arm64/' --expression='s/x86_64/amd64/')"; \
    curl --fail --location --output /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${KERNEL:?}/${ARCH:?}/kubectl"; \
    chmod +x /usr/local/bin/kubectl; \
    command -v kubectl; \
    kubectl version --client --short | grep --fixed-strings "${KUBECTL_VERSION:?}"

ENV KUSTOMIZE_VERSION=v4.5.3
RUN KERNEL="$(uname --kernel-name | tr '[:upper:]' '[:lower:]')"; \
    ARCH="$(uname --machine | sed --expression='s/aarch64/arm64/' --expression='s/x86_64/amd64/')"; \
    curl --fail --location --output kustomize.tar.gz "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_${KERNEL:?}_${ARCH:?}.tar.gz"; \
    tar --extract --gzip --file=kustomize.tar.gz --directory=/usr/local/bin --no-same-owner --no-same-permissions kustomize; \
    rm kustomize.tar.gz; \
    chmod +x /usr/local/bin/kustomize; \
    command -v kustomize; \
    kustomize version --short | grep --fixed-strings "${KUSTOMIZE_VERSION:?}"

RUN command -v awk; \
    command -v bash; \
    command -v envsubst; \
    command -v find; \
    command -v git; \
    command -v jq; \
    command -v kubectl; \
    command -v mc; \
    command -v md5sum; \
    command -v nc; \
    command -v nslookup; \
    command -v sort; \
    command -v tar

CMD ["bash"]
