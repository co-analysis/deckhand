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
#' View the example report
#'
#' @param type Either `html` (the default) or `pdf`
#' @param location Either `web` (the default) or `local`
#'
#' @export
#' @examples
#' \dontrun{
#' show_example_report()
#' }
show_example_report <- function(type = c("html", "pdf"),
                                location = c("web", "local")) {

  type <- match.arg(type)
  location <- match.arg(location)

  file_name <- paste("co_deck_layouts", type, sep = ".")

  if (location == "web") {
    url <- paste0("https://co-analysis.github.io/deckhand/", file_name)
  } else {
    url <- system.file(
      "resources", "html", file_name
    )
  }

  utils::browseURL(url)

}

# internal function to rebuild example report
render_example_report <- function(quiet = TRUE, overwrite = TRUE) {

  tmp_file = tempfile()

  # knit file
  r_file <- rmarkdown::render(
    input = "vignettes/articles/_co_deck_layouts.Rmd",
    output_file = tmp_file,
    quiet = quiet
  )

  message("Example rendered to HTML")

  # render HTML to pdf
  if (quiet) {
    verbose <- 0
  } else {
    verbose <- 1
  }

  p_file <- pagedown::chrome_print(
    r_file, wait = 2, verbose = verbose, timeout = 360
  )

  message("Example printed to PDF")

  # copy to inst/resources
  file.copy(
    r_file,
    "inst/resources/html/co_deck_layouts.html",
    overwrite = overwrite
  )
  file.copy(
    p_file,
    "inst/resources/html/co_deck_layouts.pdf",
    overwrite = overwrite
  )

  # copy to pkgdown assets
  file.copy(
    r_file,
    "pkgdown/assets/co_deck_layouts.html",
    overwrite = overwrite
  )
  file.copy(
    p_file,
    "pkgdown/assets/co_deck_layouts.pdf",
    overwrite = overwrite
  )

  message("Example HTML and PDF copied")

}
