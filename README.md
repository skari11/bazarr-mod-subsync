# Bazarr sc0ty subsync mod

This is a rebuild of wayller/bazarr-mod-subsync with subsync v 0.16

[linuxserver/bazarr](https://hub.docker.com/r/linuxserver/bazarr) [subsync](https://github.com/sc0ty/subsync) mod

## Usage

1. Setup container according to [linuxserver/bazarr](https://hub.docker.com/r/linuxserver/bazarr) - 
   add `-e DOCKER_MODS=skari10/bazarr-mod-subsync:latest`
2. Put `subsync --cli sync --sub-lang '{{subtitles_language_code3}}' --ref-lang '{{episode_language_code3}}' --sub '{{subtitles}}' --ref '{{episode}}' --out '{{subtitles}}' --overwrite` in Bazarr post-processing command setting

Subsync v0.16 is included at the moment.
