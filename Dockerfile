ARG alpine_version="3.10.3"
ARG kubectl_version="1.14.8"
ARG kind_version="0.6.0"
ARG kubeval_version="0.14.0"
FROM garethr/kubeval as collector

FROM alpine:${alpine_version}
RUN apk add curl
RUN curl -sLO "https://storage.googleapis.com/kubernetes-release/release/v${kubectl_version}/bin/linux/amd64/kubectl"
RUN chmod +x kubectl && mv kubectl -f /usr/bin/kubectl

RUN curl -sLO "https://github.com/kubernetes-sigs/kind/releases/download/v${kind_version}/kind-linux-amd64"
RUN chmod +x kind-linux-amd64 && mv kind-linux-amd64 -f /usr/bin/kind

COPY --from=collector /kubeval /usr/bin/
