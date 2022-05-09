FROM psp00:latest

WORKDIR /build
# compile atompaw-4.2.0.0
RUN wget -c http://users.wfu.edu/natalie/papers/pwpaw/atompaw-4.2.0.0.tar.gz && \
    tar xf atompaw-4.2.0.0.tar.gz
RUN cd atompaw-4.2.0.0 && \
    mkdir build && \
    cd build && \
    ../configure FC=/usr/bin/gfortran \
        --with-linalg-libs="-L/usr/local/lapack/lib -llapack -lrefblas" \
        --enable-libxc \
        --with-libxc-incs="-I/usr/local/libxc/include" \
        --with-libxc-libs="-L/usr/local/libxc/lib -lxc" && \
    make && \
    cp src/atompaw /usr/bin/atompaw42 && \
    cp src/graphatom /usr/bin/graphatom42

WORKDIR /
RUN rm -rf /build
