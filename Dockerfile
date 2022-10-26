FROM pspgen/psp-prerequisites:0.1.0

WORKDIR /build
ARG VERSION=4.2.0.2

# compile atompaw
RUN wget -c http://users.wfu.edu/natalie/papers/pwpaw/atompaw-${VERSION}.tar.gz && \
    tar xf atompaw-${VERSION}.tar.gz
RUN cd atompaw-${VERSION} && \
    mkdir build && \
    cd build && \
    ../configure FC=/usr/bin/gfortran \
        --with-linalg-libs="-L/usr/local/lapack/lib -llapack -lrefblas" \
        --enable-libxc \
        --with-libxc-incs="-I/usr/local/libxc/include" \
        --with-libxc-libs="-L/usr/local/libxc/lib -lxc" && \
    make && \
    cp src/atompaw /usr/bin/atompaw42 && \
    cp src/graphatom /usr/bin/graphatom42 && \
    ln -s /usr/bin/atompaw42 /usr/bin/atompaw && \
    ln -s /usr/bin/graphatom42 /usr/bin/graphatom

WORKDIR /
RUN rm -rf /build
