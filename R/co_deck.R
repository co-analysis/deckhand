#' CO data reports
#'
#' @param css Additional css files (default is `NULL`)
#' @param ... Arguments to pass on to [pagedown::html_paged()]
#'
#' @return
#' @export
co_deck <- function(css = NULL, ...) {

  # get base css files
  core_css <- system.file(
    "resources", "css", c("landscape.css", "report.css", "report-fonts.css"),
    package = "deckhand")

  if (!is.null(css)) {
    css <- c(core_css, css)
  } else {
    css <- core_css
  }

  pagedown::html_paged(
    css = css,
    number_sections = FALSE,
    ...
  )

}
