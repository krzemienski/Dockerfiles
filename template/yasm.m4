# Build YASM
ARG YASM_VER=1.3.0
ARG YASM_REPO=https://www.tortall.net/projects/yasm/releases/yasm-${YASM_VER}.tar.gz
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN  wget -O - ${YASM_REPO} | tar xz && \
     cd yasm-${YASM_VER} && \
     sed -i "s/) ytasm.*/)/" Makefile.in && \
     ./configure --prefix="/usr/local" --libdir=ifelse(index(DOCKER_IMAGE,ubuntu),-1,/usr/local/lib64,/usr/local/lib/x86_64-linux-gnu) && \
     make -j8 && \
     make install
