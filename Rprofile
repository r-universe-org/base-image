local({
# Use RSPM for CRAN
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))
options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))

# Enable BioConductor repos
utils::setRepositories(ind = 1:4)

# Enable universe repo(s)
my_universe <- Sys.getenv("MY_UNIVERSE")
if(nchar(my_universe)){
  my_repos <- trimws(strsplit(my_universe, ';')[[1]])
  options(repos = c(universe = my_repos, getOption("repos")))
}

# Other settings
options(crayon.enabled = TRUE)
Sys.unsetenv(c("CI", "GITHUB_ACTIONS"))
})

