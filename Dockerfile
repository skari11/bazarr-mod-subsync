## Buildstage ##
FROM lsiobase/alpine:3.11 as buildstage

# add local files
COPY root/ /root-layer/

## Install dependencies ##
RUN apk add --no-cache alsa-lib-dev \
    automake \
    autoconf \
    bison \
    build-base \ 
    curl \
    git \
    libtool \
    python3-dev \
    swig \
    tar \
    wget \
    xz && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache

WORKDIR /build

RUN wget https://sourceforge.net/projects/cmusphinx/files/sphinxbase/5prealpha/sphinxbase-5prealpha.tar.gz/download -O sphinxbase.tar.gz \
	&& tar -xzvf sphinxbase.tar.gz \
        && cd /build/sphinxbase-5prealpha \
	&& ./configure --enable-fixed \
	&& make \
	&& make install

RUN wget https://sourceforge.net/projects/cmusphinx/files/pocketsphinx/5prealpha/pocketsphinx-5prealpha.tar.gz/download -O pocketsphinx.tar.gz \
	&& tar -xzvf pocketsphinx.tar.gz \
	&& cd /build/pocketsphinx-5prealpha \
	&& ./configure \
	&& make \
	&& make install

ENV FFMPEGVER https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz

RUN mkdir /build/ffmpeg
RUN cd /build \
	&& wget "$FFMPEGVER" \
	&& tar xf ffmpeg-release-amd64-static.tar.xz --directory ffmpeg/

ENV FFMPEG_DIR /build/ffmpeg
ENV SPHINXBASE_DIR /build/sphinxbase-5prealpha
ENV POCKETSPHINX_DIR /build/pocketsphinx-5prealpha
ENV USE_PKG_CONFIG no

RUN apk add --no-cache \
	libffi-dev \
	openssl-dev \
	libgcc \
	ffmpeg-dev \
	py3-pybind11-dev
	

## Install Subsync ##
RUN git clone -b '0.15' https://github.com/sc0ty/subsync.git /app/subsync
WORKDIR /
COPY app/ /app/
WORKDIR /app/subsync
RUN pip3 install -r /app/subsync/requirements.txt \
	&& pip3 install .
	
## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
