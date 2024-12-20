output$ChrLoc_download <- downloadHandler(
  filename = function(){
    
    
    paste("ChrLoc_download_8x5_",
          as.character(input$SDArun), "_V",
          as.numeric(input$ComponentNtext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 8, height =5, compress = T, pointsize = 13)
    plot(ChrLocLoadings_Rx())
    dev.off()
  })

output$RidgeSDAScore_download <- downloadHandler(
  filename = function(){
    
    
    paste("RidgeSDAScore_download_4x4_",
          as.character(input$SDArun), "_V",
          as.numeric(input$ComponentNtext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 4, height =4, compress = T, pointsize = 13)
    plot(Ridge_SDAScoreProj_Rx())
    dev.off()
  })

output$HeatmapSDAScore_download <- downloadHandler(
  filename = function(){
    
    paste("HeatmapSDAScore_download_4x4_",
          as.character(input$SDArun), "_V",
          as.numeric(input$ComponentNtext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 4, height =5, compress = T, pointsize = 13)
    print(Heatmap_SDAScoreThr_Rx())
    dev.off()
  })



output$SDAGOneg_download <- downloadHandler(
  filename = function(){
    paste("SDAGOneg_download_6x6_",
          as.character(input$SDArun), "_V",
          as.numeric(input$ComponentNtext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 6, height =6, compress = T, pointsize = 15)
    plot(SDAGOneg_Rx())
    dev.off()
  })


output$SDAGOpos_download <- downloadHandler(
  filename = function(){
    paste("SDAGOpos_download_6x6_",
          as.character(input$SDArun), "_V",
          as.numeric(input$ComponentNtext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 6, height =6, compress = T, pointsize = 15)
    plot(SDAGOpos_Rx())
    dev.off()
  })



output$UMAPscoreProj_download <- downloadHandler(
  filename = function(){
    paste("UMAPscoreProj_download_5x5_",
          as.character(input$SDArun), "_V",
          as.numeric(input$ComponentNtext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 5, height =5, compress = T, pointsize = 15)
    plot(DimRedux_SDAScoreProj_Rx())
    dev.off()
  })


output$UMAPgeneExpr_download <- downloadHandler(
  filename = function(){
    paste("UMAPgeneExpr_download_5x5_",
          as.character(input$SDArun), "_",
          as.character(input$Genetext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 5, height =5, compress = T, pointsize = 15)
    plot(DimRedux_geneExpr_Rx())
    dev.off()
  })

output$Boxplot_GeneExprThr_download  <- downloadHandler(
  filename = function(){
    paste("Boxplot_GeneExprThr_download_5x5_",
          as.character(input$SDArun), "_",
          as.character(input$Genetext), ".pdf", sep = "")
  },
  content = function(file) {
    pdf(file, width = 5, height =5, compress = T, pointsize = 15)
    plot(Boxplot_GeneExprThr_Rx())
    dev.off()
  })

