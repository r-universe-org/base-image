ARG BASE_IMAGE=ghcr.io/r-universe-org/base-image:latest
FROM $BASE_IMAGE

ENV VERSION="next"
#ENV VERSION="devel"

# R-devel dailies from: https://github.com/rstudio/r-builds#README

RUN curl -o install.deb -LSsf "https://cdn.posit.co/r/ubuntu-2404/pkgs/r-${VERSION}_1_$(dpkg --print-architecture).deb" &&\
	apt install --reinstall -y -o=Dpkg::Use-Pty=0 -o=Apt::Cmd::Disable-Script-Warning=1 ./install.deb && rm install.deb &&\
	sed -i.bak 's|-g ||g' /opt/R/${VERSION}/lib/R/etc/Makeconf &&\
	cp -f /etc/R/Rprofile.site /opt/R/${VERSION}/lib/R/etc/ &&\
	cp -f /etc/R/Renviron.site /opt/R/${VERSION}/lib/R/etc/

ENV PATH="/opt/R/${VERSION}/bin:${PATH}"

RUN /opt/R/${VERSION}/bin/R --version