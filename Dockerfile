FROM ubuntu:jammy

ENV DEBIAN_FRONTEND noninteractive

# R-patched ppa can be removed after 4.2.3 release

RUN \
    apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:marutter/rrutter4.0 && \
    add-apt-repository -y ppa:cran/r-patched && \
    apt-get update && \
    apt-get install -y \
    cargo \
    cmake \
    coinor-libcbc-dev  \
    coinor-libsymphony-dev \
    curl \
    fonts-emojione \
    git \
    global \
    hugo \
    iputils-ping && \
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
    libfreetype6-dev \
    libfribidi-dev \
    libgdal-dev \
    libgeos-dev \
    libgit2-dev \
    libglpk-dev \
    libglu1-mesa-dev \
    libgpgme-dev \
    libgsl-dev \
    libharfbuzz-dev \
    libhdf5-dev \
    libhiredis-dev \
    libicu-dev \
    libjpeg-dev \
    libjq-dev \
    libmagick++-dev \
    libmpfr-dev \
    libmysqlclient-dev \
    libnetcdf-dev \
    libnng-dev \
    libopenbabel-dev \
    libopenblas0 \
    libopencv-dev \
    libpng-dev \
    libpoppler-cpp-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libprotoc-dev \
    librabbitmq-dev \
    librdf0 \
    librrd-dev \
    librsvg2-dev \
    libsasl2-dev \
    libsecret-1-dev \
    libsodium-dev \
    libsodium-dev \
    libssh-dev \
    libssh2-1-dev \
    libssl-dev \
    libtesseract-dev \
    libtiff-dev \
    libudunits2-dev \
    libv8-dev \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    libzmq3-dev \
    protobuf-compiler \
    python3-numpy \
    python3-pip \
    r-base-dev \
    r-cran-rjava \
    rsync \
    tesseract-ocr-eng \
    texinfo \
    ttf-mscorefonts-installer \
    unixodbc-dev \
    wget \
    zlib1g-dev && \
    apt-get clean


# Patched libraptor2-dev because dependency libcurl4-gnutls-dev conflicts with libcurl4-openssl-dev
RUN \
    add-apt-repository -y ppa:cran/librdf && \
    apt-get install -y librdf0-dev && \
    apt-get clean

# The pandoc package in ubuntu 20.04 seems too old for certain things
RUN \
  curl -OL "https://github.com/jgm/pandoc/releases/download/2.16.2/pandoc-2.16.2-linux-amd64.tar.gz" &&\
  tar xzvf pandoc-2.16.2-linux-amd64.tar.gz -C/usr/local --strip 1 &&\
  rm pandoc-2.16.2-linux-amd64.tar.gz

COPY Renviron /etc/R/Renviron.site
COPY Rprofile /etc/R/Rprofile.site

# NB: Docker says $HOME should be available but it isnt so we hardcode /root for now
ENV PATH="/root/bin:${PATH}"

# Install TinyTex + common packages and put it on the PATH
RUN R -e 'install.packages("tinytex");tinytex:::install_prebuilt("TinyTeX")' && \
    rm -f TinyTeX.tar.gz && \
    tlmgr option repository https://ctan.math.illinois.edu/systems/texlive/tlnet

# Disable debug flags and things that dont work in docker
RUN \
  rm -f /usr/bin/timedatectl &&\
  rm -f /etc/ImageMagick-6/policy.xml &&\
  sed -i.bak 's|-g ||g' /etc/R/Makeconf
