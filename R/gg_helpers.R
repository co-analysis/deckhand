# Functions for themeing plots

#' Produce tints of hex colours
#'
#' A function to produce a tinted version of a hexadecimal colour code
#'
#' @param colour The colour to tint
#' @param tint The percentage tint desired, higher is 'lighter'
#' @param bg_colour The background colour to tint against, defaults to white
#'
#' @return
#' @export
tint_hex <- function(colour, tint, bg_colour = "#ffffff") {

  colour <- gsub("#", "", colour)
  bg_colour <- gsub("#", "", bg_colour)

  bg_red   <- strtoi(substr(bg_colour, 1, 2), 16)
  bg_green <- strtoi(substr(bg_colour, 3, 4), 16)
  bg_blue  <- strtoi(substr(bg_colour, 5, 6), 16)

  red   <- strtoi(substr(colour, 1, 2), 16)
  green <- strtoi(substr(colour, 3, 4), 16)
  blue  <- strtoi(substr(colour, 5, 6), 16)

  red_tint   <-   round(red * tint) +   round(bg_red * (1 - tint))
  green_tint <- round(green * tint) + round(bg_green * (1 - tint))
  blue_tint  <-  round(blue * tint) +  round(bg_blue * (1 - tint))

  tint_colour <- paste0("#",
                        format(as.hexmode(red_tint), width = 2),
                        format(as.hexmode(green_tint), width = 2),
                        format(as.hexmode(blue_tint), width = 2),
                        collapse = "")

  return(tint_colour)

}

#' Report plot theme
#'
#' Provide common styling to ggplot objects
#'
#' @param base The base ggplot theme (either minimal or void)
#' @param legend_position The location of the plot legend
#' @param legend_title The title for the legend or "none" (the default) for no
#'   title
#' @param axis_text Which axis to include text for: "both" (the default), "x",
#'   "y" or "none"
#' @param axis_title Which axis to include titles for: "both", "x", "y" or
#'   "none" (the default)
#'
#' @export
theme_co_report <- function(
    base = "minimal",
    legend_position = "top",
    legend_title = "none",
    axis_text = "both",
    axis_title = "none"
) {

  if (base == "void") {
    t <- ggplot2::theme_void()
  } else if (base == "minimal") {
    t <- ggplot2::theme_minimal()
  } else {
    stop("base must be minimal or void")
  }

  if (legend_title == "none") {
    legend_title <- ggplot2::element_blank()
  }

  if (axis_text == "both") {
    axis_text <- ggplot2::element_text(size = 9)
    axis_text_x <- axis_text
    axis_text_y <- axis_text
  } else if (axis_text == "x") {
    axis_text <- ggplot2::element_blank()
    axis_text_x <- ggplot2::element_text(size = 9)
    axis_text_y <- axis_text
  } else if (axis_text == "y") {
    axis_text <- ggplot2::element_blank()
    axis_text_x <- axis_text
    axis_text_y <- ggplot2::element_text(size = 9)
  } else if (axis_text == "none") {
    axis_text <- ggplot2::element_blank()
    axis_text_x <- axis_text
    axis_text_y <- axis_text
  }

  if (axis_title == "both") {
    axis_title <- ggplot2::element_text(size = 9)
    axis_title_x <- axis_title
    axis_title_y <- axis_title
  } else if (axis_title == "x") {
    axis_title <- ggplot2::element_blank()
    axis_title_x <- ggplot2::element_text(size = 9)
    axis_title_y <- axis_title
  } else if (axis_title == "y") {
    axis_title <- ggplot2::element_blank()
    axis_title_x <- axis_title
    axis_title_y <- ggplot2::element_text(size = 9)
  } else if (axis_title == "none") {
    axis_title <- ggplot2::element_blank()
    axis_title_x <- axis_title
    axis_title_y <- axis_title
  }


  t + ggplot2::theme(
    text = ggplot2::element_text(family = "Heebo", size = 9,
                                 colour = unname(co_colours["grey"])),
    title = ggplot2::element_text(family = "Heebo", size = 9, face = "bold"),
    axis.title = axis_title,
    axis.title.x = axis_title_x,
    axis.title.y = axis_title_y,
    axis.text = axis_text,
    axis.text.x = axis_text_x,
    axis.text.y = axis_text_y,
    panel.grid = ggplot2::element_blank(),
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.title = ggplot2::element_text(margin = ggplot2::margin(b = 6)),
    plot.caption = ggplot2::element_text(size = 8, hjust = 0, face = "plain"),
    plot.margin = ggplot2::margin(t = 3, r = 3, b = 3, l = 3),
    strip.text = ggplot2::element_text(size = 9, face = "bold",
                                       colour = unname(co_colours["grey"])),
    legend.position = legend_position,
    legend.title = legend_title
  )

}


#' Use CO colours for colour scales
#'
#' The scale_*_co() functions provide a way to easily apply a colour from the
#' CO corporate palette to a chart, the take a single colour name and apply
#' tints of that colour to the relevant series (colour/fill).
#'
#' @param colour    A colour name from [co_colours()] for scale_colour_co()
#' @param fill      A colour name from [co_colours()] for scale_fill_co()
#' @param direction The direction of the scale
#' @param show.na   Whether to show NA values
#' @param ...       Other arguments passed to discrete scale
#'
#' @name scale_co
#' @aliases NULL
NULL

#' @rdname scale_co
#' @export
scale_colour_co <- function(..., colour, direction = 1, show.na = FALSE) {
  .scale_co(..., what = "colour", colour = colour, direction = direction,
            show.na = show.na)
}

#' @rdname scale_co
#' @export
scale_fill_co <- function(..., fill, direction = 1, show.na = FALSE) {
  .scale_co(..., what = "fill", colour = fill, direction = direction,
            show.na = show.na)
}

#' Vector of CO colours
#'
#' A vector of Cabinet Office's corporate palette
#'
#' @export
co_colours <- c(
  blue       = "#005abb",
  light_blue = "#5bb4e5",
  grey       = "#4d4e53",
  light_grey = "#cacac8",
  dark_blue  = "#1a2792",
  violet     = "#78256e",
  red        = "#a23138",
  orange     = "#cc5a13",
  yellow     = "#ecac00",
  green      = "#879637",
  aqua       = "#57bab7"
)


.tint_pal <- function(colour) {
  force(colour)
  function(n) {
    if (n > 8) {
      warning("There are more than 8 colour/fill groups.", call. = FALSE)
    }

    limit <- switch(n,
                    1,
                    0.6,
                    0.6,
                    0.4)

    if (is.null(limit)) {
      limit <- 0.4
    }

    purrr::map_chr(
      .x = seq(1, limit, length.out = n),
      .f = ~tint_hex(colour, .x)
    )

  }
}

.scale_co <- function(..., what, colour, direction = 1, show.na = FALSE) {

  if (!(colour %in% names(co_colours))) {
    stop("colour '", colour,"' not recognised")
  } else {
    colour <- unname(co_colours[colour])
  }

  if (show.na) {
    na.value <- unname(co_colours["light_grey"])
  } else {
    na.value <- NA
  }

  ggplot2::discrete_scale(
    aesthetics = what,
    scale_name = "co_scale",
    palette = .tint_pal(colour),
    na.translate = show.na,
    na.value = na.value,
    ...
  )

}

#' Show palette colours
#'
#' A function to show the CO colour palette
#'
#' @export
show_co_colours <- function() {
  ggplot2::ggplot(
    data = tibble::tibble(
      x = 1, y = 1,
      name = forcats::as_factor(names(co_colours)),
      value = unname(co_colours)
    ),
    ggplot2::aes(x = x, y = y, fill = name)
  ) +
    ggplot2::geom_tile(width = 0.1, height = 0.1, show.legend = FALSE) +
    ggplot2::geom_text(ggplot2::aes(label = value),
                       size = 3.25, family = "Heebo",
                       colour = unname(co_colours["grey"]),
                       nudge_y = -0.075, show.legend = FALSE) +
    ggplot2::scale_fill_manual(values = co_colours) +
    ggplot2::coord_fixed(ylim = c(0.9, 1.05)) +
    ggplot2::facet_wrap(~name, ncol = 6) +
    theme_co_report(axis_text = "none")
}
