
FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get install -y \
        curl \
	git \
        gettext && \
    rm -rf /var/lib/apt/lists/*

ENV KUBECTL_VERSION v1.10.9
RUN curl --fail -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl

ENV KUSTOMIZE_VERSION 1.0.10
RUN curl --fail -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64 -o /usr/local/bin/kustomize \
 && chmod +x /usr/local/bin/kustomize

CMD ["bash"]
