# Use RSPM for CRAN
options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))
options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))

# Enable BioConductor repo
utils::setRepositories(ind = 1:2)

# Enable dev repo
my_universe <- Sys.getenv("MY_UNIVERSE")
if(nchar(my_universe)){
  options(repos = c(universe = my_universe, getOption("repos")))
}

# Other settings
options(crayon.enabled = TRUE)
