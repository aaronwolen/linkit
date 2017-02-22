# wrap vector in double quotes
dquote <- function(x) {
  shQuote(x, type = "cmd")
}

# validate supplied IDs
# PMID format:
#   - see PMC-ids.csv.gz from https://www.ncbi.nlm.nih.gov/pmc/pmctopmid
check_id <- function(id, type) {
  pattern <- switch(type,
      go = "^GO:[0-9]{7}$",
    kegg = "^[a-z]{3,4}[0-9]{5}$",
  pubmed = "^[0-9]{3,8}$",
  entrez = "^[0-9]{1,9}$",
   stock = "^[[:alnum:]]{1,4}$",
    cran = "^[[:alpha:]][\\w\\.]+(?<!\\.)$",
    bioc = "^[[:alpha:]][\\w\\.]+(?<!\\.)$"
  )
  valid <- grepl(pattern, id, perl = TRUE)
  if (all(valid)) {
    return(id)
  } else {
    invalid <- id[!valid]
    n <- length(invalid)
    if (n == 1) {
      stop(invalid, " is not a valid ", type, " identifier", call. = FALSE)
    } else {
      stop(n, " of the supplied ", type,
           " idenfitiers are invalid including:\n",
           paste0(" -", invalid, "\n")[seq_len(min(10, n))], call. = FALSE)
    }
  }
}

# substitute magic variables (e.g., "<var>") for requested values
#' @importFrom memoise memoise
sub_var <- memoise::memoise(
  function(x, id, db) {
    is.magic <- isTRUE(grepl("^<[a-z]+>$", x))
    if (is.null(x) | !is.magic) return(x)
    field <- gsub("[<>]", "", x)

    switch(db,
      pubmed = pubmed_query(id, field),
      entrez = entrez_query(id, field),
      stock  = stock_query(id, field)
    )
  }
)

# check for R base packages
is_base_pkg <- function(x) {
  x %in% c("base", "compiler", "datasets", "grDevices", "graphics", "grid",
           "methods", "parallel", "profile", "splines", "stats", "stats4",
           "tcltk", "tools", "translations", "utils")
}
