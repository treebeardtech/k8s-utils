ARG VARIANT="hirsute"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

WORKDIR /home/vscode
USER vscode
ENV CI true
ENV PATH "/home/vscode/bin:${PATH}"

RUN mkdir install
COPY install/apts.sh install
RUN ./install/apts.sh

COPY install/binaries.sh install
RUN ./install/binaries.sh

COPY install/pips.sh install
RUN ./install/pips.sh

RUN helm plugin install https://github.com/databus23/helm-diff --version v3.4.0

COPY .zshrc .
COPY install/terminal.sh install
RUN ./install/terminal.sh 

RUN mkdir .config
COPY starship.toml .config

ENV CI false