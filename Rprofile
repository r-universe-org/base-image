local({
# Currently RSPM does not have binaries for R 4.2 yet
rver <- getRversion()
if(rver > "4.1.3") rver <- "4.1.3"
options(HTTPUserAgent = sprintf("R/%s R (%s)", rver, paste(rver, R.version$platform, R.version$arch, R.version$os)))
options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))

# Enable BioConductor repos
utils::setRepositories(ind = 1:4, addURLs = c(fallback = "https://cloud.r-project.org"))

# Enable universe repo(s)
my_universe <- Sys.getenv("MY_UNIVERSE")
if(nchar(my_universe)){
  my_repos <- trimws(strsplit(my_universe, ';')[[1]])
  options(repos = c(universe = my_repos, getOption("repos")))
}

# Other settings
options(crayon.enabled = TRUE)
Sys.unsetenv(c("CI", "GITHUB_ACTIONS"))

# Dummy token for API limits
if(is.na(Sys.getenv("GITHUB_PAT", NA))){
  dummy <- c('ghp_SXg', 'LNM', 'Tu4cnal', 'tdqkZtBojc3s563G', 'iqv')
  Sys.setenv(GITHUB_PAT = paste(dummy, collapse = 'e'))
}
})

