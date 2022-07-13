ARG VARIANT="hirsute"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

WORKDIR /home/vscode
USER vscode
ENV CI true
# ENV PATH "/home/vscode/bin:${PATH}"

RUN mkdir install
COPY install/apts.sh install
RUN ./install/apts.sh

ENV PATH="/home/vscode/.nix-profile/bin/:${PATH}"
ENV USER=vscode

RUN nix-env \
  -f https://github.com/NixOS/nixpkgs/archive/bf972dc380f36a3bf83db052380e55f0eaa7dcb6.tar.gz \
  -iA \
  python310 \
  docker \
  jq \
  shellcheck

RUN nix-env \
  -f https://github.com/NixOS/nixpkgs/archive/141439f6f11537ee349a58aaf97a5a5fc072365c.tar.gz \
  -iA \
  kubectl

RUN nix-env \
  -f https://github.com/NixOS/nixpkgs/archive/c82b46413401efa740a0b994f52e9903a4f6dcd5.tar.gz \
  -iA \
  helmfile \
  kubernetes-helm-wrapped

RUN nix-env \
  -f https://github.com/NixOS/nixpkgs/archive/6d02a514db95d3179f001a5a204595f17b89cb32.tar.gz \
  -iA \
  eksctl

RUN nix-env \
  -f https://github.com/NixOS/nixpkgs/archive/22.05.tar.gz \
  -iA \
  yq-go

RUN nix-env \
  -f https://github.com/NixOS/nixpkgs/archive/85bd5aa3e7fc0603b4fa848ae951ffddd0dfbbae.tar.gz \
  -iA \
  gatekeeper

RUN nix-env \
  -f https://github.com/NixOS/nixpkgs/archive/d1c3fea7ecbed758168787fe4e4a3157e52bc808.tar.gz \
  -iA \
  awscli2

COPY install/binaries.sh install
RUN ./install/binaries.sh

COPY install/pips.sh install
RUN ./install/pips.sh

RUN chmod +w /nix/store/*-helm-plugins/
RUN helm plugin install https://github.com/databus23/helm-diff --version v3.4.0

COPY .zshrc .
COPY install/terminal.sh install
RUN ./install/terminal.sh 

RUN mkdir .config
COPY starship.toml .config

ENV CI false