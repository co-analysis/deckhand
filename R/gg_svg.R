#' Insert plot as SVG
#'
#' A function to convert a ggplot object to an SVG image for rendering
#' in the deckhand column/row grid structure
#'
#' @param gg_plot The ggplot to convert
#' @param width The width of the plot, in page columns
#' @param height The height of the plot, in page columns
#'
#' @return
#' @export
insert_svg <- function(gg_plot, width, height) {

  if (width > 12 | width < 1) {
    stop("width is not in columns")
  }

  if (height > 12 | width < 1) {
    stop("height is not in columns")
  }

  # convert dimensions to mm
  width <-  ((width  * 20) + ((width - 1) * 2)) - 4
  height <- ((height * 12) + ((height - 1) * 2)) - 4

  svg_file <- paste0(tempfile(),".svg")
  ggplot2::ggsave(svg_file, gg_plot, device = "svg",
                  width = width, height = height, units = "mm")
  x <- readr::read_lines(svg_file)[-1]
  x <- stringr::str_replace_all(x, " font-family: [\\w\\s]+;", "")
  x <- stringr::str_replace_all(x, "font-weight: bold;", "font-weight: 500;")
  htmltools::HTML(paste(x, sep = "\n"))
}

#' Export report plot as PNG
#'
#' Export report plots with a sizing similar to that of the plot created by
#' [insert_svg()]. Plots are exported as png, file names will be coerced as necessary.
#'
#' @param gg_plot The ggplot to render
#' @param filename The file to export
#' @param width The width in report columns
#' @param height The height in report columns
#'
#' @export
export_plot <- function(gg_plot, filename, width, height) {

  if (tolower(tools::file_ext(filename)) != "png") {
    filename <- gsub(paste0("\\.", tools::file_ext(filename),"$"), ".png", filename)
    warning("filename was not a png, renamed")
  }

  if (width > 12 | width < 1) {
    stop("width is not in columns")
  }

  if (height > 12 | width < 1) {
    stop("height is not in columns")
  }

  # convert dimensions to mm
  width <-  ((width  * 20) + ((width - 1) * 2)) - 4
  height <- ((height * 12) + ((height - 1) * 2)) - 4

  showtext::showtext_auto()
  ggplot2::ggsave(filename = filename, plot = gg_plot, dev = "png",
                  width = width, height = height, units = "mm")
  message("plot exported as ", filename)

}
