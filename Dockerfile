FROM ubuntu:noble AS base_image

ENV DEBIAN_FRONTEND=noninteractive
ENV CARGO_HOME="/opt/.cargo"
ENV RUSTUP_HOME="/opt/.rustup"
ENV PATH="/root/bin:/opt/.cargo/bin:${PATH}"

FROM base_image AS builder

RUN \
    apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:marutter/rrutter4.0 && \
    apt-get update && \
    apt-get install -y \
    cmake \
    coinor-libcbc-dev  \
    coinor-libsymphony-dev \
    curl \
    flac \
    fonts-emojione \
    git \
    global \
    hugo \
    iputils-ping \
    jags \
    language-pack-en-base \
    libapparmor-dev \
    libarchive-dev \
    libavfilter-dev \
    libbam-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libdb-dev \
    libeigen3-dev \
    libelf-dev \
    libfftw3-dev \
    libfluidsynth-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libgdal-dev \
    libgeos-dev \
    libgit2-dev \
    libglpk-dev \
    libglu1-mesa-dev \
    libgpgme-dev \
    libgrpc++-dev \
    libgsl-dev \
    libharfbuzz-dev \
    libhdf5-dev \
    libhiredis-dev \
    libicu-dev \
    libjpeg-dev \
    libjq-dev \
    libmagick++-dev \
    libmpc-dev \
    libmpfr-dev \
    libmysqlclient-dev \
    libnetcdf-dev \
    libnng-dev \
    libopenbabel-dev \
    libopenblas0 \
    libopencv-dev \
    libopenmpi-dev \
    libpng-dev \
    libpoppler-cpp-dev \
    libpoppler-glib-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libprotoc-dev \
    librabbitmq-dev \
    librdf0 \
    librrd-dev \
    librsvg2-dev \
    libsasl2-dev \
    libsbml5-dev \
    libsecret-1-dev \
    libsodium-dev \
    libsodium-dev \
    libssh-dev \
    libssh2-1-dev \
    libssl-dev \
    libtesseract-dev \
    libtiff-dev \
    libudunits2-dev \
    libunwind-dev \
    libv8-dev \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    libzmq3-dev \
    mono-runtime \
    ocl-icd-opencl-dev \
    protobuf-compiler \
    protobuf-compiler-grpc \
    python3-numpy \
    python3-pip \
    r-base-dev \
    r-cran-rjava \
    rsync \
    tesseract-ocr-eng \
    texinfo \
    tk-dev \
    ttf-mscorefonts-installer \
    unixodbc-dev \
    wget \
    xclip \
    xvfb \
    zlib1g-dev && \
    apt-get clean


# Patched libraptor2-dev because dependency libcurl4-gnutls-dev conflicts with libcurl4-openssl-dev
# This is only for ubuntu-jammy; is this no longer needed or should we port it?
#RUN \
#    add-apt-repository -y ppa:cran/librdf && \
#    apt-get install -y librdf0-dev && \
#    rm -fv /etc/apt/sources.list.d/* && \
#    apt-get clean

# Use recent pandoc for quarto
RUN \
  curl -L -o pandoc.tar.gz "https://github.com/jgm/pandoc/releases/download/3.6.4/pandoc-3.6.4-linux-$(dpkg --print-architecture).tar.gz" &&\
  tar xzvf pandoc.tar.gz -C/usr/local --strip 1 &&\
  rm pandoc.tar.gz

RUN \
  curl -L -o quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.43/quarto-1.6.43-linux-$(dpkg --print-architecture).deb" &&\
  dpkg -i quarto.deb &&\
  rm quarto.deb

RUN \
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

COPY Renviron /etc/R/Renviron.site
COPY Rprofile /etc/R/Rprofile.site

RUN \
  BIOC_DEVEL=$(curl -sS --fail https://bioconductor.org/config.yaml | grep 'devel_version' | grep -o '[.0-9]*') &&\
  echo "R_BIOC_VERSION=${BIOC_DEVEL}" >> /etc/R/Renviron.site &&\
  cat /etc/R/Renviron.site

# Install TinyTex + common packages and put it on the PATH
RUN R -e 'install.packages("tinytex");tinytex::install_tinytex(bundle="TinyTeX")' && \
    tlmgr update --self && \
    tlmgr option repository https://ctan.math.illinois.edu/systems/texlive/tlnet &&\
    tlmgr install inputenx

# Disable debug flags and things that dont work in docker
RUN \
  rm -f /usr/bin/timedatectl &&\
  rm -f /etc/ImageMagick-6/policy.xml &&\
  sed -i.bak 's|-g ||g' /etc/R/Makeconf

# Workaround for packages depending on float:::ldflags() such as rsparse
RUN (cd "/usr/lib/$(arch)-linux-gnu"; ln -s libopenblas.so.0 libopenblas.so)

# Squash builder image into
FROM base_image
COPY --from=builder / /
