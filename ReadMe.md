# Docker image for dotnet + mono + monogame

# docker

[![Docker Stars](https://img.shields.io/docker/stars/gableroux/dotnet-mono-monogame.svg)](https://hub.docker.com/r/gableroux/dotnet-mono-monogame)
[![Docker Pulls](https://img.shields.io/docker/pulls/gableroux/dotnet-mono-monogame.svg)](https://hub.docker.com/r/gableroux/dotnet-mono-monogame)
[![Docker Automated](https://img.shields.io/docker/automated/gableroux/dotnet-mono-monogame.svg)](https://hub.docker.com/r/gableroux/dotnet-mono-monogame)
[![Docker Build](https://img.shields.io/docker/build/gableroux/dotnet-mono-monogame.svg)](https://hub.docker.com/r/gableroux/dotnet-mono-monogame)
[![Image](https://images.microbadger.com/badges/image/gableroux/dotnet-mono-monogame.svg)](https://microbadger.com/images/gableroux/dotnet-mono-monogame)
[![Version](https://images.microbadger.com/badges/version/gableroux/dotnet-mono-monogame.svg)](https://microbadger.com/images/gableroux/dotnet-mono-monogame)
[![Layers](https://images.microbadger.com/badges/image/gableroux/dotnet-mono-monogame.svg)](https://microbadger.com/images/gableroux/dotnet-mono-monogame)

This is a docker image used to build games created with [monogame](http://www.monogame.net/) using `dotnet` command line. It was inspired by [gmantaos/monogame-docker](https://github.com/gmantaos/monogame-docker) and [CL0SeY/dotnet-mono-docker](https://github.com/CL0SeY/dotnet-mono-docker).

## Examples

### Command line

```bash
docker pull gableroux/dotnet-mono-monogame:latest
docker run --rm -it -v "$PWD:/app" gableroux/dotnet-mono-monogame bash
```

Once inside the container:

```bash
cd /app
dotnet build project_name.csproj
```

### CircleCI

`circle.yml` (to be tested)

```yaml
version: 2

.job_configuration: &job_configuration
  docker:
    - image: gableroux/dotnet-mono-monogame
  working_directory: ~/repo
  steps:
    - checkout
    - run: dotnet restore
    - run: chmod +x /root/.nuget/packages/monogame.content.builder/3.7.0.4/build/MGCB/build/ffprobe
    - run: chmod +x /root/.nuget/packages/monogame.content.builder/3.7.0.4/build/MGCB/build/ffmpeg
    - run: dotnet build PROJECT_NAME.csproj --configuration $BUILDCONFIGURATION
    - run: dotnet publish -r $BUILDPLATFORM --configuration $BUILDCONFIGURATION /p:TrimUnusedDependencies=true
    - store_artifacts:
        path: ~/repo/bin/release/netcoreapp2.2/$BUILDPLATFORM/publish

jobs:
  windows:
    <<: *job_configuration
    environment:
      BUILDCONFIGURATION: 'release'
      BUILDPLATFORM: 'win-x64'
  linux:
    <<: *job_configuration
    environment:
      BUILDCONFIGURATION: 'release'
      BUILDPLATFORM: 'linux-x64'
  macos:
    <<: *job_configuration
    environment:
      BUILDCONFIGURATION: 'release'
      BUILDPLATFORM: 'osx-x64'

workflows:
  version: 2
  workflow:
    jobs:
      - windows
      - linux
      - macos
```

## Troubleshooting

> Error : Importer 'WavImporter' had unexpected failure! [...] build/MGCB/build/ffprobe [...] Native error= Access denied

This seems to be a problem with nuget monogame installation during the restore command. It doesn't restore the executable mode on `ffmpeg` and `ffprobe` command lines.

**workaround**:

```bash
chmod +x /root/.nuget/packages/monogame.content.builder/3.7.0.4/build/MGCB/build/ffprobe
chmod +x /root/.nuget/packages/monogame.content.builder/3.7.0.4/build/MGCB/build/ffmpeg
```

Run these two commands right after the restore command.

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)

