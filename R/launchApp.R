#' Launch BASSAA
#' @title Launch BASSAA
#' @description Launch BASSAA
#' @keywords shiny SDA PBMC B27 Ankylosing Spondylitis and Acute Anterior Uveitis Atlas
#' @export
#' @return Shiny application.
#' @import shiny
#' @import shinydashboard
#' @import shinyWidgets
#' @import shinyFiles
#' @import data.table
#' @import ggplot2
#' @import ggforce
#' @import ggthemes
#' @import ggpubr
#' @import ggnewscale
#' @import ggrepel
#' @import rclipboard
#' @import grid
#' @import gridExtra
#' @import stringr
#' @import viridis
#' @import RColorBrewer
#' @import BiocParallel
#' @import clusterProfiler
#' @import AnnotationHub
#' @import org.Hs.eg.db
#' @import org.Mmu.eg.db
#' @import biomaRt
#' @import SDAtools
#' @import profvis

#' 
launchBASSAA <- function(...) {
  ## runApp() does not work w shiny-server
  shinyAppDir(appDir = system.file("app", package = "BASSAA"))
  
}
launchBASSAA.profile <- function(interval = 0.5, ...) {
  ## runApp() does not work w shiny-server
  require(profvis)
  profvis({
    shinyAppDir(appDir = system.file("app", package = "BASSAA"), options = list(display.mode = "normal"))
  }, interval = interval)
}