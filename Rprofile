# Repositories
local({
  r_branch <- substr(getRversion(), 1, 3)
  distro <- system2('lsb_release', '-sc', stdout = TRUE)
  binary_universe <- function(universe){
    sprintf("%s/bin/linux/%s/%s", universe, distro, r_branch)
  }
  bioc_urls <- function(){
    ver <- utils:::.BioC_version_associated_with_R_version();
    c(
      BioCsoft = sprintf("https://bioconductor.posit.co/packages/%s/bioc", ver),
      BioCann = sprintf("https://bioconductor.posit.co/packages/%s/data/annotation", ver),
      BioCexp = sprintf("https://bioconductor.posit.co/packages/%s/data/experiment", ver)
    )
  }
  options(repos = c(
    P3M = sprintf("https://p3m.dev/all/__linux__/%s/latest", distro),
    BIOC = binary_universe("https://bioc.r-universe.dev"),
    CRAN = "https://cloud.r-project.org",
    CRANHAVEN = binary_universe("https://cranhaven.r-universe.dev"),
    bioc_urls()
  ))
  options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))

  my_universe <- Sys.getenv("MY_UNIVERSE")
  if(nchar(my_universe)){
    options(repos = c(binaries = binary_universe(my_universe), universe = my_universe, getOption("repos")))
  }
})

# Other settings
options(crayon.enabled = TRUE)
Sys.unsetenv(c("CI", "GITHUB_ACTIONS"))

# Read-only dummy token for API limits
if(is.na(Sys.getenv("GITHUB_PAT", NA))){
  Sys.setenv(GITHUB_PAT = paste(c('ghp_SXg', 'LNM', 'Tu4cnal', 'tdqkZtBojc3s563G', 'iqv'), collapse = 'e'))
}
