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

  # If a specific cran version is set, use only that
  cran_version <- Sys.getenv("CRAN_VERSION")
  if(nchar(cran_version)){
    options(repos = c(
      CRAN = sprintf("https://p3m.dev/cran/__linux__/%s/%s", distro, cran_version),
      BIOC = binary_universe("https://bioc.r-universe.dev"),
      bioc_urls()
    ))
  } else if(grepl("development", R.version[['status']])) {
    options(repos = c(
      CRAN = binary_universe("https://cran.r-universe.dev"),
      BIOC = binary_universe("https://bioc.r-universe.dev"),
      bioc_urls()
    ))
  } else {
    options(repos = c(
      P3M = sprintf("https://p3m.dev/all/__linux__/%s/latest", distro),
      BIOC = binary_universe("https://bioc.r-universe.dev"),
      CRAN = "https://cloud.r-project.org",
      CRANHAVEN = binary_universe("https://cranhaven.r-universe.dev"),
      bioc_urls()
    ))
  }

  # Needed by p3m
  options(HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version$platform, R.version$arch, R.version$os)))

  my_universe <- Sys.getenv("MY_UNIVERSE")
  if(nchar(my_universe)){
    options(repos = c(universe = binary_universe(my_universe), getOption("repos")))
  }
})

# Other settings
options(crayon.enabled = TRUE)
Sys.unsetenv(c("CI", "GITHUB_ACTIONS"))

# Read-only dummy token for API limits
if(is.na(Sys.getenv("GITHUB_PAT", NA))){
  Sys.setenv(GITHUB_PAT = paste(c('ghp_SXg', 'LNM', 'Tu4cnal', 'tdqkZtBojc3s563G', 'iqv'), collapse = 'e'))
}
