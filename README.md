# Bazarr with sc0ty's subsync

[linuxserver/bazarr](https://hub.docker.com/r/linuxserver/bazarr) (latest) with [subsync](https://github.com/sc0ty/subsync) - synchronize your subtitles when downloaded.

## Usage

1. Setup container according to [linuxserver/bazarr](https://hub.docker.com/r/linuxserver/bazarr) - 
   add `-e DOCKER_MODS=wayller/docker-bazarr`
2. Put `subsync --cli sync --sub-lang '{{subtitles_language_code3}}' --sub '{{subtitles}}' --ref '{{episode}}' --out '{{subtitles}}' --overwrite` in Bazarr post-processing command setting
