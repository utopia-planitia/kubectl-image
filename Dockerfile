
FROM ubuntu:19.10

RUN apt-get update -y && \
    apt-get install -y \
        curl \
        git \
        gettext-base \
        netcat \
        jq && \
    rm -rf /var/lib/apt/lists/*

ENV MINIO_VERSION mc.RELEASE.2019-10-09T22-54-57Z
RUN curl --fail -L -o mc https://dl.min.io/client/mc/release/linux-amd64/archive/${MINIO_VERSION} && \
    chmod +x mc && \
    mv mc /usr/local/bin/mc

ENV KUBECTL_VERSION v1.14.8
RUN curl --fail -L -o kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

ENV KUSTOMIZE_VERSION 1.0.11
RUN curl --fail -L -o kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 && \
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
