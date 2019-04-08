# Docker image for dotnet + mono + monogame

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

See [./examples/circle.yml](examples/circle.yml) (to be tested)

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

