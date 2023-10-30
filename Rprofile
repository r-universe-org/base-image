local({
rver <- getRversion()
distro <- system2('lsb_release', '-sc', stdout = TRUE)
options(HTTPUserAgent = sprintf("R/%s R (%s); r-universe (%s)", rver, paste(rver, R.version$platform, R.version$arch, R.version$os), distro))
options(repos = c(CRAN = sprintf("https://p3m.dev/cran/__linux__/%s/latest", distro)))

# Enable BioConductor repos
utils::setRepositories(ind = 1:4, addURLs = c(fallback = "https://cloud.r-project.org"))

# Enable universe repo(s)
my_universe <- Sys.getenv("MY_UNIVERSE")
if(nchar(my_universe)){
  my_repos <- trimws(strsplit(my_universe, ';')[[1]])
  binaries <- sprintf('%s/bin/linux/%s/%s', my_repos[1], distro, substr(rver, 1, 3))
  options(repos = c(binaries = binaries, universe = my_repos, getOption("repos")))
}

# Temp workaround for archived rgdal/geos stuff
options(repos = c(getOption("repos"), snapshot = "https://p3m.dev/cran/2023-10-13/"))

# Other settings
options(crayon.enabled = TRUE)
Sys.unsetenv(c("CI", "GITHUB_ACTIONS"))

# Dummy token for API limits
if(is.na(Sys.getenv("GITHUB_PAT", NA))){
  dummy <- c('ghp_SXg', 'LNM', 'Tu4cnal', 'tdqkZtBojc3s563G', 'iqv')
  Sys.setenv(GITHUB_PAT = paste(dummy, collapse = 'e'))
}
})
