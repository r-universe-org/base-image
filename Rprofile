# Repositories
local({
  r_branch <- substr(getRversion(), 1, 3)
  distro <- system2('lsb_release', '-sc', stdout = TRUE)
  binary_universe <- function(universe){
    sprintf("%s/bin/linux/%s-%s/%s", universe, distro, R.version$arch, r_branch)
  }
  bioc_urls <- function(){
    c(
      BioCsoft = "https://bioconductor.posit.co/packages/devel/bioc",
      BioCann = "https://bioconductor.posit.co/packages/devel/data/annotation",
      BioCexp = "https://bioconductor.posit.co/packages/devel/data/experiment"
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
  } else if(grepl("development", R.version[['status']]) || grepl("aarch", R.version$arch)) {
    # TODO: remove condition above once p3m has arm64 binaries
    options(repos = c(
      CRAN = binary_universe("https://cran.r-universe.dev"),
      BIOC = binary_universe("https://bioc.r-universe.dev"),
      bioc_urls()
    ))
  } else {
    options(repos = c(
      P3M = sprintf("https://p3m.dev/all/__linux__/%s/latest", distro),
      CRAN = binary_universe("https://cran.r-universe.dev"),
      BIOC = binary_universe("https://bioc.r-universe.dev"),
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
