FROM quay.io/devspaces/udi-rhel8:3.5

ENV KUBESEAL_VERSION=0.20.1 \
    HUB_VERSION=2.14.2 \
    K9S_VERSION=0.27.3


USER root

ADD passwd.template ${HOME}/passwd.template
RUN mkdir ${HOME}/.ssh && chown user:root ${HOME}/.ssh && chmod 775 ${HOME}/.ssh

RUN wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-amd64.tar.gz && \
    tar -xvzf kubeseal-${KUBESEAL_VERSION}-linux-amd64.tar.gz kubeseal && \
    install -m 775 kubeseal /usr/local/bin/kubeseal && \
    rm -rf kubeseal-${KUBESEAL_VERSION}-linux-amd64.tar.gz

RUN wget packages.httpie.io/binaries/linux/http-latest -o http && \
    install -m 755 http /usr/local/bin/http

RUN wget https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz && \
    tar -xvzf hub-linux-amd64-${HUB_VERSION}.tgz && \
    install -m 755 hub-linux-amd64-${HUB_VERSION}/bin/hub /usr/local/bin/hub && \
    rm -rf hub-linux-amd64-${HUB_VERSION} hub-linux-amd64-${HUB_VERSION}.tgz

RUN wget https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_amd64.tar.gz && \
    tar -xvzf k9s_Linux_amd64.tar.gz k9s && \
    install -m 755 k9s /usr/local/bin/k9s && \
    rm -rf k9s_Linux_amd64.tar.gz

RUN dnf install -y \
          nano \
          vim \
          zsh \
    && dnf -y clean all && rm -rf /var/cache

RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/PixelJonas/dotfiles.git ${HOME}/.dotfiles && \
    cd ${HOME}/.dotfiles && \
    script/minimal && \
    zsh/pre-install.sh
