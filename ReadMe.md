# Docker image for dotnet + mono + monogame

This is a docker image used to build games created with monogame using `dotnet` command line.

## Examples

Command line

```bash
docker pull gableroux/dotnet-mono-monogame:latest
docker run --rm -it -v "$PWD:/app" gableroux/dotnet-mono-monogame bash
```

Once inside the container:

```bash
cd /app
dotnet build project_name.csproj
```

## Troubleshooting

> Error : Importer 'WavImporter' had unexpected failure! [...] build/MGCB/build/ffprobe [...] Native error= Access denied

This seems to be a problem with nuget monogame installation during the restore command. It doesn't restore the executable mode on `ffmpeg` and `ffprobe` command lines.

**workaround**:

```bash
chmod +x /root/.nuget/packages/monogame.content.builder/3.7.0.4/build/MGCB/build/ffprobe
chmod +X /root/.nuget/packages/monogame.content.builder/3.7.0.4/build/MGCB/build/ffmpeg
```

Run these two commands right after the restore command.

## License

[MIT](LICENSE.md) © [Gabriel Le Breton](https://gableroux.com)

