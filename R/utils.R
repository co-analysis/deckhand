#' CO logo
#'
#' A simple function to return the embedded logo, either as an html element or
#' the file path to the image.
#'
#' @param out Either `html` or `path`
#'
#' @return
#' @export
co_logo <- function(out = c("html", "path")) {

  out <- match.arg(out)

  path <- system.file("resources", "img", "co-logo.svg", package = "deckhand")

  if (out == "html") {
    x <- htmltools::img(src = path)
  } else if (out == "path") {
    x <- path
  } else {
    stop("out must either be 'html' or 'path'")
  }

  return(x)

}
