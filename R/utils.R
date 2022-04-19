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

#' Open example report in the browser
#'
#' An example report showing layout options is provided in the package. This
#' function loads the report in your browser
#'
#' @export
show_example_report <- function() {

  example_report <- paste0(
    "file://",
    system.file("resources", "html", "co_deck.html", package = "deckhand")
  )

  utils::browseURL(example_report)

}

# internal function to rebuild example report
render_example_report <- function(quiet = TRUE, overwrite = TRUE) {

  tmp_file = tempfile()

  # knit file
  rmarkdown::render(
    input = "vignettes/articles/_co_deck.Rmd",
    output_file = tmp_file,
    quiet = quiet
  )

  # copy to inst/resources
  file.copy(
    paste0(tmp_file,".html"),
    "inst/resources/html/co_deck_layouts.html",
    overwrite = overwrite
  )

  # copy to pkgdown assets
  file.copy(
    paste0(tmp_file,".html"),
    "pkgdown/assets/co_deck_layouts.html",
    overwrite = overwrite
  )

  message("Example report knited and copied")

}
