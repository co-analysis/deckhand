# Functions to assist in formatting {gt} objects


#' Export a {gt} pipeline into output format
#'
#' Take an table constructed via the {gt} package and format it so
#' that it will work with the {pagedown} report template and css files.
#'
#' @param x The gt table
#' @param id A unique id for the table
#' @param min_max_styling Convert min/max flags to css classes
#' @param drop_header Drop the table header row(s)
#' @param small Whether to render in a smaller font
#'
#' @export
output_table <- function(x,
                         id = NULL,
                         min_max_styling = FALSE,
                         drop_header = FALSE,
                         small = FALSE) {

  # convert gt object to raw html
  # if provided html check for gt classes
  if ("gt_tbl" %in% class(x)) {
    x <- gt::as_raw_html(x, inline_css = FALSE)
  } else if ("html" %in% class(x)) {
    if (!grepl("class=\"gt_table\"", x)) {
      stop("html object does not contain gt classes")
    }
  } else {
    stop("table is not a gt_tbl or html object")
  }

  # remove embedded style info
  x <- .destyle_tab(x)

  # add table id
  if (!is.null(id)) {
    if (is.character(id) & length(id) == 1 & id != "") {

      id <- stringr::str_replace_all(id, "\\s", "_")

      x <- .add_tab_id(x, id)

    } else {
      stop("table id must be a character vector of length 1")
    }

  }

  # apply min-max styling
  if (min_max_styling) {
    x <- .min_max_styler(x)
  }

  # drop table header
  if (drop_header) {
    x <- .drop_tab_head(x)
  }

  if (small) {
    x <- .tbl_small_class(x)
  }

  htmltools::HTML(x)

}


.drop_tab_head <- function(x) {
  x <- gsub("<thead.*thead>", "", x)
}

.add_tab_id <- function(x, id) {
  x <- gsub("(<table)( class=\"gt_table\">)",
            paste0("\\1 id=\"", id, "\"\\2", collapse = ""),
            x)
}

.tbl_small_class <- function(x, id) {
  x <- gsub("<tbody class=\"gt_table_body\">",
            "<tbody class=\"gt_table_body tbl-small\">",
            x)
}

.min_max_styler <- function(x) {

  if (!grepl("(<td class=\".*)(\">.*) !!(min|max)!!(<\\/td>)", x)) {
    warning("no min/max flags identified, add !!min!! or !!max!! to apply css classes")
  }

  x <- stringr::str_replace_all(
    x,
    "(<td class=\".*)(\">.*) !!(min|max)!!(<\\/td>)",
    "\\1 \\3_val\\2\\4"
  )
}


.destyle_tab <- function(x) {
  x <- gsub("(<div.*)(<table.*table>)(.*)","\\2", x)
}
