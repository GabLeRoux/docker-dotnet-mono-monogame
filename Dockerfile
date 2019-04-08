FROM mcr.microsoft.com/dotnet/core/sdk:2.2

ARG MONO_VERSION=5.18.1.0
ENV MONO_VERSION $MONO_VERSION

RUN apt update \
    && apt install -y apt-transport-https dirmngr gnupg ca-certificates \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/debian stretch/snapshots/$MONO_VERSION main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt update \
	&& apt-get install -y mono-devel fsharp mono-vbnc nuget referenceassemblies-pcl \
	&& rm -rf /var/lib/apt/lists/*

ARG MONOGAME_VERSION=3.7.1
ENV MONOGAME_VERSION $MONOGAME_VERSION

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget gtk-sharp3 \
    zip \
    && wget -O monogame-sdk.run https://github.com/MonoGame/MonoGame/releases/download/v$MONOGAME_VERSION/monogame-sdk.run \
    && chmod +x monogame-sdk.run \
    && yes | ./monogame-sdk.run \
    && apt-get remove -y wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
