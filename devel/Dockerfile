FROM ghcr.io/r-universe-org/base-image:latest

RUN curl -OLSs https://cdn.posit.co/r/ubuntu-2404/pkgs/r-devel_1_amd64.deb &&\
	apt install --reinstall -y -o=Dpkg::Use-Pty=0 -o=Apt::Cmd::Disable-Script-Warning=1 ./r-devel_1_amd64.deb &&\
	rm r-devel_1_amd64.deb &&\
	sed 's/getRversion()/"4.4.0"/g' /etc/R/Rprofile.site > /opt/R/devel/lib/R/etc/Rprofile.site &&\
	sed -i.bak 's|-g ||g' /opt/R/devel/lib/R/etc/Makeconf &&\
	ln -s /etc/R/Renviron.site /opt/R/devel/lib/R/etc/

# Workaround for missing sysreq install in r-universe
RUN apt install -y libquantlib0-dev

ENV PATH="/opt/R/devel/bin:${PATH}"
