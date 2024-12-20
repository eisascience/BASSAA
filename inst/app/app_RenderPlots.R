

# DimRedux_geneExpr -----
output$DimRedux_geneExpr <- renderPlot({
  # print("DimRedux_geneExpr")
  DimRedux_geneExpr_Rx()

})

## DimRedux_SDAScoreProj -----
output$DimRedux_SDAScoreProj <- renderPlot({
  DimRedux_SDAScoreProj_Rx()
})


## DimRedux_Meta -----
output$DimRedux_Meta <- renderPlot({
  DimRedux_Meta_Rx()+
    theme(legend.position = "none", aspect.ratio=1,
          legend.title = element_blank())
})


## DimRedux_MetaLegend -----
output$DimRedux_MetaLegend <- renderPlot({
  
  legend <- cowplot::get_legend(DimRedux_Meta_Rx())
  
  #grid.newpage()
  grid.draw(legend)
})

## chrom loading location -----

output$ChrLoc <- renderPlot({
  
  ChrLocLoadings_Rx()
  
})

## Ridge_SDAScoreProj -----
output$Ridge_SDAScoreProj <- renderPlot({
  Ridge_SDAScoreProj_Rx()
})


## Heatmap_SDAScoreThr -----
output$Heatmap_SDAScoreThr <- renderPlot({
  print(Heatmap_SDAScoreThr_Rx())
})



## GO enrichment plots ------

output$GOpos <- renderPlot({

  SDAGOpos_Rx()

})

output$GOneg <- renderPlot({

  SDAGOneg_Rx()

})



## Gene Expression plots ------

output$Boxplot_GeneExprThr <- renderPlot({

  Boxplot_GeneExprThr_Rx()

})

output$Barplot_GeneExprPercAbove <- renderPlot({

  Barplot_GeneExprPercAbove_Rx()

})





### tables


output$packageTablePos <- renderTable({
  # print_gene_list(as.numeric(input$ComponentNtext), PosOnly = T) %>%
  #   #group_by(package) %>%
  #   #tally() %>%
  #   #arrange(desc(n), tolower(package)) %>%
  #   #mutate(percentage = n / nrow(pkgData()) * 100) %>%
  #   #select("Package name" = package, "% of downloads" = percentage) %>%
  #   as.data.frame() %>%
  #   head(as.numeric(input$NoOfGenes))
  geneLoadingVec = SDAComp_Selec_Rx()
  Out1 <- names(sort(geneLoadingVec, decreasing = T))[1:as.numeric(input$NoOfGenes)]
  Out1
}, digits = 1)


## packageTableNeg -----

output$packageTableNeg <- renderTable({
  # print_gene_list(as.numeric(input$ComponentNtext), NegOnly = T) %>%
  #   #group_by(package) %>%
  #   #tally() %>%
  #   #arrange(desc(n), tolower(package)) %>%
  #   #mutate(percentage = n / nrow(pkgData()) * 100) %>%
  #   #select("Package name" = package, "% of downloads" = percentage) %>%
  #   as.data.frame() %>%
  #   head(as.numeric(input$NoOfGenes))
  geneLoadingVec = SDAComp_Selec_Rx()
  Out2 <- names(sort(geneLoadingVec, decreasing = F))[1:as.numeric(input$NoOfGenes)]
  Out2
}, digits = 1)

