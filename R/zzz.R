# Register fonts
.setup_fonts <- function() {

  font_path <- system.file("resources", "fonts", "Heebo", package = "deckhand")

  sysfonts::font_add(
    family = "Heebo",
    regular = file.path(font_path, "Heebo-Light.ttf"),
    bold = file.path(font_path, "Heebo-Medium.ttf")
  )

  if (interactive() & .Platform$OS.type == "windows") {
    showtext::showtext_auto()
  }

}

.onLoad <- function(...){

  .setup_fonts()

}
