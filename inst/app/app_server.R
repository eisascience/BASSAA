AddPer <- function(x, perc=0.1){
  x + x *  perc
}


# datat <- data.table(datat)


# output$SDACompOrigin <- renderValueBox({
#   valueBox(
#     value = colnames(results$scores)[as.numeric(input$ComponentNtext)], #format(Sys.time(), "%a %b %d %X %Y %Z"),
#     subtitle = DataMetaDF[paste0("sda.", unlist(strsplit(colnames(results$scores)[as.numeric(input$ComponentNtext)], split = "\\."))[2]) ,]$ObjName,
#     icon = icon("area-chart"),
#     color = "yellow" #if (downloadRate >= input$rateThreshold) "yellow" else "aqua"
#   )
# })


# input = list(ComponentNtext = 1)
# DataMetaDF[paste0("sda.", unlist(strsplit(colnames(results$scores)[as.numeric(input$ComponentNtext)], split = "\\."))[2]) ,]$ObjName                           
