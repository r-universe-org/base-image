ARG BASE_IMAGE=ghcr.io/r-universe-org/base-image:latest
FROM $BASE_IMAGE

# r-devel origin (intel): https://cdn.posit.co/r/ubuntu-2404/pkgs/r-devel_1_amd64.deb
# r-devel origin:(arm) https://github.com/r-hub/R/releases/download/vdevel/r-rstudio-ubuntu-2404-devel_1_arm64.deb

RUN if [ $(dpkg --print-architecture) = "arm64" ]; then \
	DOWNLOAD="https://github.com/r-hub/R/releases/download/vdevel/r-rstudio-ubuntu-2404-devel_1_arm64.deb"; \
	else \
	DOWNLOAD="https://cdn.posit.co/r/ubuntu-2404/pkgs/r-devel_1_amd64.deb"; \
	fi &&\
	curl -o r-devel.deb -LSs "$DOWNLOAD" &&\
	apt install --reinstall -y -o=Dpkg::Use-Pty=0 -o=Apt::Cmd::Disable-Script-Warning=1 ./r-devel.deb && rm r-devel.deb &&\
	sed -i.bak 's|-g ||g' /opt/R/devel/lib/R/etc/Makeconf &&\
	cp -f /etc/R/Rprofile.site /opt/R/devel/lib/R/etc/ &&\
	cp -f /etc/R/Renviron.site /opt/R/devel/lib/R/etc/

ENV PATH="/opt/R/devel/bin:${PATH}"
