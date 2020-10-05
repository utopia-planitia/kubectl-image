
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y \
        curl \
        git \
        gettext-base \
        netcat \
        dnsutils \
        jq && \
    rm -rf /var/lib/apt/lists/*

ENV MINIO_VERSION RELEASE.2020-10-03T02-54-56Z
RUN curl --fail -L -o mc https://dl.min.io/client/mc/release/linux-amd64/archive/mc.${MINIO_VERSION} && \
    chmod +x mc && \
    mv mc /usr/local/bin/mc

ENV KUBECTL_VERSION v1.17.5
RUN curl --fail -L -o kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

ENV KUSTOMIZE_VERSION v3.8.4
RUN curl --fail -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz | \
    tar -xzf - kustomize && \
    chmod +x kustomize && \
    mv kustomize /usr/local/bin/kustomize

CMD ["bash"]

RUN which bash
RUN which find
RUN which sort
RUN which tar
RUN which md5sum
RUN which awk
RUN which mc
RUN which kubectl
RUN which envsubst
RUN which nslookup
