ARG alpine_version="3.10.3"
ARG kubeval_version="0.14.0"
FROM garethr/kubeval as kubeval_collector

FROM bitnami/kubectl as kubectl_collector

FROM alpine:${alpine_version}
RUN apk add curl
RUN curl -sLO "https://storage.googleapis.com/kubernetes-release/release/v${kubectl_version}/bin/linux/amd64/kubectl"
RUN chmod +x kubectl && mv kubectl -f /usr/bin/kubectl

COPY --from=kubeval_collector /kubeval /usr/bin/
COPY --from=kubectl_collector /opt/bitnami/kubectl/bin/kubectl /usr/bin/

