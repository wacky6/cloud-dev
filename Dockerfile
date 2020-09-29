FROM debian:stable
LABEL maintainer="Jiewei Qian <qjw@wacky.one>"

ENV WORKDIR="/workspace/" \
    TZ="Asis/Shanghai" \
    CODE_SERVER_BIN="/usr/local/code-server/bin/code-server"

ARG ARCH="amd64"
ENV ARCH=$ARCH
ARG CODE_SERVER_VER="3.5.0"

ARG PKGS="zsh git curl tar gzip procps"
ARG VSC_EXTENSIONS="eamodio.gitlens"

USER root
WORKDIR ${WORKDIR}

COPY /dev-env/* /dev-env/

RUN    apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y ${PKGS} \
    && export CODE_SERVER_DIR=$( dirname $( dirname $CODE_SERVER_BIN ) ) \
    && mkdir $CODE_SERVER_DIR \
    && curl -fsSL https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VER}/code-server-${CODE_SERVER_VER}-linux-${ARCH}.tar.gz | tar xz -C $CODE_SERVER_DIR --strip-components=1 \
    && export CODE_SERVER_DEFAULT_SETTINGS_PATH="${HOME}/.local/share/code-server/User/settings.json" \
    && mkdir -p $( dirname ${CODE_SERVER_DEFAULT_SETTINGS_PATH} ) \
    && echo '{"workbench.colorTheme": "Default Dark+"}' > $CODE_SERVER_DEFAULT_SETTINGS_PATH \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && chsh -s $(which zsh) \
    && git clone --depth 1 https://github.com/wacky6/my_zshrc ${HOME}/my_zshrc \
    && rm -f ${HOME}/.zshrc \
    && ln -s ${HOME}/my_zshrc/zshrc ${HOME}/.zshrc \
    && apt-get clean \
    && /dev-env/install-extensions.sh ${VSC_EXTENSIONS}

EXPOSE 9000

ENTRYPOINT ["/dev-env/dev-init.sh"]