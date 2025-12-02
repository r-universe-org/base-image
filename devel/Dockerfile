ARG BASE_IMAGE=ghcr.io/r-universe-org/base-image:latest
FROM $BASE_IMAGE

# R-devel dailies from: https://github.com/rstudio/r-builds#README

RUN curl -o r-devel.deb -LSsf "https://cdn.posit.co/r/ubuntu-2404/pkgs/r-devel_1_$(dpkg --print-architecture).deb" &&\
	apt install --reinstall -y -o=Dpkg::Use-Pty=0 -o=Apt::Cmd::Disable-Script-Warning=1 ./r-devel.deb && rm r-devel.deb &&\
	sed -i.bak 's|-g ||g' /opt/R/devel/lib/R/etc/Makeconf &&\
	cp -f /etc/R/Rprofile.site /opt/R/devel/lib/R/etc/ &&\
	cp -f /etc/R/Renviron.site /opt/R/devel/lib/R/etc/

ENV PATH="/opt/R/devel/bin:${PATH}"
