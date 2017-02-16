#' Construct urls to online databases
#'
#' These database-specific functions return a bare url (i.e., not a hyperlink)
#' to the relevant online database based on the provided identifier.
#'
#' @param id valid identifier for the relevant online database
#'
#' @examples
#' # gene ontology url
#' go_url("GO:0005539")
#'
#' # KEGG pathway url
#' kegg_url("hsa04915")
#'
#' # PubMed article url
#' pubmed_url("23193287")
#' @name urls
NULL

#' @export
#' @describeIn urls for Gene Ontology Consortium
go_url <- function(id) {
  paste0("http://amigo.geneontology.org/amigo/term/",
         check_id(id, "go"))
}

#' @export
#' @describeIn urls for KEGG Pathway Database
kegg_url <- function(id) {
  paste0("http://www.genome.jp/dbget-bin/www_bget?pathway:",
         check_id(id, "kegg"))
}

#' @export
#' @describeIn urls for PubMed based on PMID (PubMed identifier)
pubmed_url <- function(id) {
  paste0("https://www.ncbi.nlm.nih.gov/pubmed/", check_id(id, "pmid"))
}

#' @export
#' @describeIn urls for NCBI's database for gene-specific information based
#'   on Entrez ID
entrez_url <- function(id) {
  paste0("https://www.ncbi.nlm.nih.gov/gene/", check_id(id, "entrez"))
}