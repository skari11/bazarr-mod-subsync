## Buildstage ##
FROM lsiobase/alpine:3.11 as buildstage

## Download dependencies ##
RUN apk add --no-cache \
	wget \
	git

WORKDIR /root-layer/build

RUN git clone https://github.com/cmusphinx/sphinxbase.git /root-layer/build/sphinxbase \
	&& git clone https://github.com/cmusphinx/pocketsphinx.git /root-layer/build/pocketsphinx

ENV FFMPEGVER https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz

RUN mkdir /root-layer/build/ffmpeg
RUN cd /root-layer/build \
	&& wget "$FFMPEGVER" \
	&& tar xf ffmpeg-release-amd64-static.tar.xz --directory ffmpeg/

## Download Subsync ##
RUN git clone -b '0.15' https://github.com/sc0ty/subsync.git /root-layer/app/subsync
WORKDIR /root-layer/
COPY app/ /root-layer/app/
	
# add local files
COPY root/ /root-layer/

RUN chmod +x /root-layer/app/subsync
	
## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
