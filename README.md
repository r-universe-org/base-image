# Base image ![badge](https://img.shields.io/docker/image-size/runiverse/base)

A docker image for building R source packages and documentation. Contains:

 - Latest Ubuntu LTS release
 - Current stable R-release version
 - Rprofile which enables [p3m binaries](https://p3m.dev) for CRAN packages
 - Commonly needed system libraries for R packages
 - A TinyTex installation

To test this locally use:

```
docker run -it runiverse/base bash
```

If you would like to support other system libraries on R-universe, you can send a pull request, but please be aware we need to keep the size of the image managable, because it gets pulled in for every build.
