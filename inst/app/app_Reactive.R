
CellSelector <- reactive({

  
  
  SelectedCells1 <- switch(input$condiselect,
                           "hconly" = rownames(subset(datat, Cond1 %in% c("HC_B27-", "HC_B27+", "HC"))),
                           "as_hc" = rownames(subset(datat, Cond1 %in% c("HC_B27-", "HC_B27+", "HC", "AS_B27+", "AS"))),
                           "aau_hc" = rownames(subset(datat, Cond1 %in% c("HC_B27-", "HC_B27+", "HC", "AAU_B27+"))),
                           "asaau_hc" = rownames(subset(datat, Cond1 %in% c("HC_B27-", "HC_B27+", "HC", "AS_AAU_B27+"))),
                           "all" = rownames(subset(datat, Cond1 %in% c("HC_B27-", "HC_B27+", "HC", "AS_B27+", "AAU_B27+", "AS_AAU_B27+", "AS"))),
                           NULL)
  
  # table(datat$CellType0)
  # sum(is.na( table(datat$CellType0)))
  
  
  SelectedCells2 <- switch(input$mctselect,
                          "tnks" = rownames(subset(datat, CellType0 %in% c("TNK"))),
                          "myeloids" = rownames(subset(datat, CellType0 %in% c("Myeloid"))),
                          "bcells" = rownames(subset(datat, CellType0 %in% c("Bcell"))),
                          "tnkb" = rownames(subset(datat, CellType0 %in% c("Bcell", "TNK"))),
                          "tnkm" = rownames(subset(datat, CellType0 %in% c("Myeloid", "TNK"))),
                          "mb" = rownames(subset(datat, CellType0 %in% c("Bcell", "Myeloid"))),
                          "all" = rownames(subset(datat, CellType0 %in% c("TNK", "Bcell", "Myeloid"))),
                          NULL)
  
  SelectedCells3 <- switch(input$originselect,
                           "tejpal" = rownames(subset(datat, Origin == "Tejpal")),
                           "gse194315" = rownames(subset(datat, Origin != "Tejpal")),
                           "both" = rownames(datat),
                           NULL)
  
  SelectedCells = intersect(intersect(SelectedCells1, SelectedCells2), SelectedCells3)
  
  # print(input$condiselect)
  # print(head(SelectedCells))
  # SelectedCells = rownames(subset(datat, CellType0 %in% c("TNK")))
  return(SelectedCells)
  
})

SDAComp_Name_Rx <- reactive({
  # CompName <- "sda.561999.V27"
  
  CompName <- switch(input$SDAComp,
                           "TNK Cytotoxic Module (TCM)" = "sda.561999.V27",
                           "B-Cell Defect (BCD)" = "sda.561999.V76",
                           "Myeloid regulation imbalance (MRI)" = "sda.583600.V48",
                           "pDC-monocyte differential (PMD)" = "sda.583600.V65",
                           
                           NULL)
  return(CompName)
})

SDAComp_Selec_Rx <- reactive({
  
  # geneLoadingVec = SDAls$sda.561999[, "sda.561999.V27"]
  geneLoadingVec <- switch(input$SDAComp,
                           "TNK Cytotoxic Module (TCM)" = SDAls$sda.561999[, "sda.561999.V27"],
                           
                           "B-Cell Defect (BCD)" = SDAls$sda.561999[, "sda.561999.V76"],
                           "Myeloid regulation imbalance (MRI)" = SDAls$sda.583600[, "sda.583600.V48"],
                           "pDC-monocyte differential (PMD)" = SDAls$sda.583600[, "sda.583600.V65"],
                           
                           NULL)
  return(geneLoadingVec)
})

DimRedux_AllCells_DF_Rx <- reactive({
  # SelectedCells <- rownames(datat)
  SelectedCells <- CellSelector()
  

  tempDF <- datat[SelectedCells, c("rpcar1umap_1", "rpcar1umap_2")]
  
  
  colnames(tempDF) <- c("Dim1", "Dim2")
  
  tempDF$Dim1 <- as.numeric(tempDF$Dim1)
  tempDF$Dim2 <- as.numeric(tempDF$Dim2)
  

  
  tempDF$GeneExpr <- rep(0, nrow(tempDF))
  
  # print(head(tempDF))
  # SelectedCells = intersect(SelectedCells, rownames(tempDF))
  tempDF = tempDF[SelectedCells, ]
  # print(head(tempDF_X))
  # print(SelectedCells)
  return(tempDF)
})

MetaSelector <- reactive({
  SelectedCells = rownames(as.data.frame(DimRedux_AllCells_DF_Rx()))
  # sum(is.na(datat$Cond2))
  # table(datat$Cond2)
  
  MetaFac <- switch(input$metaselect,
                    "azimuthl2" = datat[SelectedCells, ]$CellType,
                    # "azimuthl3" = datat[SelectedCells, ]$CellType0,
                    "subjectid" = datat[SelectedCells, ]$SubjectId2,
                    "condid1" = datat[SelectedCells, ]$Cond1,
                    "condid2" = datat[SelectedCells, ]$Cond2,
                    "sex" = datat[SelectedCells, ]$Sex,
                    "b27" = datat[SelectedCells, ]$B27pos,
                    # "phase" = datat[SelectedCells, ]$Phase,
                    "majorcelltype" = datat[SelectedCells, ]$CellType0,
                    NULL)
  # print(head(MetaFac))
  
  # MetaFac = datat[SelectedCells, ]$CellType
  
  names(MetaFac) = SelectedCells
  return(MetaFac)
})

GeneExprDF_Rx <- reactive({

  tempDF = as.data.frame(DimRedux_AllCells_DF_Rx())
  SelectedCells = rownames(tempDF)
  
  # all(SelectedCells %in% colnames(GEXred))
  
  #since we only added GEX for Mahyari-Gill dataset to reduce load times
  OverlapCells = intersect(colnames(GEXred), SelectedCells)
  
  # length(SelectedCells)
  # length(OverlapCells)
  # setdiff(SelectedCells, OverlapCells)
  
  # SelectedCells = intersect(rownames(results$scores), SelectedCells)
  GEXredred = GEXred[, OverlapCells]
  
  
  MetaFac <- MetaSelector()
  
  
  # if(as.character(input$Genetext) %in% colnames(results$loadings[[1]])){
  #   # results$loadings[[1]][,"PRM1"]
  #   GeneExpr <- as.data.frame(results$scores[SelectedCells,KeepComps] %*% results$loadings[[1]][KeepComps,as.character(input$Genetext)])
  # } else {
  #   GeneExpr <- as.data.frame(results$scores[SelectedCells,KeepComps] %*% rep(0, nrow(results$loadings[[1]][KeepComps, ])))
  #   
  # }
  
  if(as.character(input$Genetext) %in% rownames(GEXredred)){
    # GeneExpr <- as.data.frame(GEXredred["CD3E",])
    
    GeneExpr <- as.data.frame(GEXredred[as.character(input$Genetext),])
  } else {
    GeneExpr <- as.data.frame(rep(0, ncol(GEXredred) ))
    
  }
  
  
  GeneExpr$Meta = MetaFac[OverlapCells]
  
  colnames(GeneExpr) = c("GeneExpr", "Meta")
  # input = list()
  # input$GeneThr = 0.2
  
  GT=T
  CutThresh = as.numeric(input$GeneThr)
  
  GeneExpr$GtThr = "BelowThreshold"
  
  
  if(GT) GeneExpr$GtThr[GeneExpr[,"GeneExpr"]>=CutThresh] = "AboveThreshold"
  if(!GT) GeneExpr$GtThr[GeneExpr[,"GeneExpr"]<CutThresh] = "AboveThreshold"
  
  # GeneExpr = subset(GeneExpr, Meta !="other")
  
  return(GeneExpr)
})

DimRedux_geneExpr_Rx <- reactive({
  

  tempDF <- as.data.frame(DimRedux_AllCells_DF_Rx())
  GeneExpr <- as.data.frame(GeneExprDF_Rx())
  
  tempDF <- tempDF[intersect(rownames(GeneExpr), rownames(tempDF)),]
  

  tempDF[rownames(GeneExpr), ]$GeneExpr <- GeneExpr[,1]
  # table(cut(tempDF$GeneExpr, breaks = c(-Inf, 0, 0.8, 1.5, 2.5, 3, Inf)))
  # plot(density(tempDF$GeneExpr))
  
  
  
  tempDF <- tempDF %>%
    arrange(GeneExpr)
  
  ggplot(tempDF[sample(rownames(tempDF), DownSampN, replace = F),], aes(Dim1, Dim2, color = cut(GeneExpr, breaks = c(-Inf, 0, 0.8, 1.8, 2.5, 3, Inf)))) +
    geom_point(size = 0.1) + 
    theme_classic(base_size = 10) +
    scale_color_manual("EX", 
                       values = rev(c("red", "orange", "yellow", "skyblue", "dodgerblue", "navy"))) +
    guides(colour = guide_legend(override.aes = list(size = 2, alpha = 1))) +
    theme(legend.position = "bottom", aspect.ratio = 1) +
    coord_cartesian(xlim = NULL, ylim = NULL, expand = FALSE) +
    labs(title = paste("Gene: ", input$Genetext, sep = ""),
         caption = "Normed GEX")
})

DimRedux_SDAScoreProj_Rx <- reactive({
  # SelectedCells = CellSelector()
  
  
  tempDF <- as.data.frame(DimRedux_AllCells_DF_Rx())
  SelectedCells = rownames(tempDF)
  
  # SelectedCells = intersect(rownames(results$scores), SelectedCells)
  # tempDF = tempDF[SelectedCells, ]
  
  CompName <- SDAComp_Name_Rx()
  tempDF$SDAComp = datat[SelectedCells, CompName]

  # print(head(tempDF))
  
  ggplot(tempDF[sample(rownames(tempDF), DownSampN, replace = F),], 
         aes(Dim1, Dim2, color=cut(asinh(SDAComp), breaks = c(-Inf, -1, -.5, 0, .5, 1, Inf)))) +
    geom_point(size=0.1) + theme_classic(base_size = 10) +
    scale_color_manual("CS", values = rev(c("red", "orange", "yellow", "lightblue", "dodgerblue", "blue")) ) + 
    guides(colour = guide_legend(override.aes = list(size=2, alpha=1))) +
    theme(legend.position = "bottom", aspect.ratio=1) + 
    # ggtitle(paste0("SDAV", input$ComponentNtext, " \n", sep="")) + 
    # ggtitle(paste0(input$SDAComp, sep="")) +
    simplify2  + coord_cartesian(xlim = NULL, ylim = NULL, expand = FALSE)
  
  
})

DimRedux_Meta_Rx <- reactive({
  
  tempDF <- as.data.frame(DimRedux_AllCells_DF_Rx())
  MetaFac <- MetaSelector()
  SelectedCells = rownames(tempDF)
  
  # SelectedCells = intersect(rownames(results$scores), SelectedCells)
  # tempDF = tempDF[SelectedCells, ]
  

  tempDF$Meta = naturalsort::naturalfactor(as.character(MetaFac[SelectedCells]))
    
  
 
  #ggplotly
  ggplot(tempDF[sample(rownames(tempDF), DownSampN, replace = F),], aes(Dim1, Dim2, color= Meta)) +
    geom_point(size=0.1)+ theme_classic(base_size = 10) +
    theme(legend.position = "right", aspect.ratio=1,
          legend.title = element_blank()) +
    # ggtitle("t-SNE - Final Pheno") +
    scale_color_manual(values=(col_vector)) + 
    guides(colour = guide_legend(override.aes = list(size=2, alpha=1), ncol =2))  +
    coord_cartesian(xlim = NULL, ylim = NULL, expand = FALSE)
  
  
})

Ridge_SDAScoreProj_Rx <- reactive({
  

  # if(! (as.numeric(input$ComponentNtext) %in% 1:nrow(results$loadings[[1]]))){
  #   print("No Comp")
  # } else {
    
    tempDF <- as.data.frame(DimRedux_AllCells_DF_Rx())
    SelectedCells = rownames(tempDF)
    MetaFac <- MetaSelector()[SelectedCells]
    
    CompName <- as.character(SDAComp_Name_Rx())
    # tempDF$SDAComp = datat[SelectedCells,CompName]
    
    # SelectedCells = intersect(rownames(results$scores), SelectedCells)
    # tempDF = tempDF[SelectedCells, ]
    # MetaFac = MetaFac[SelectedCells]
    
    # input=list()
    # input$SDAcutThr = .3
    
    tempDF2 = data.frame(SDAscore =datat[SelectedCells, CompName], 
                        Meta = naturalsort::naturalfactor(as.character(MetaFac)))
    
    ggplot(tempDF2, aes(x = asinh(SDAscore), y = Meta, fill = Meta)) +
      geom_density_ridges() +
      theme_ridges() + 
      theme(legend.position = "none") + geom_vline(xintercept = as.numeric(input$SDAcutThr), col="red", lwd=.5, lty=2)
    
  # }
  
  
})

Heatmap_SDAScoreThr_Rx <- reactive({
  
  
  
  
  # if(! (as.numeric(input$ComponentNtext) %in% 1:nrow(results$loadings[[1]]))){
  #   print("No Comp")
  # } else {
    
    MetaFac <- MetaSelector()
    tempDF <- as.data.frame(DimRedux_AllCells_DF_Rx())
    SelectedCells = rownames(tempDF)
    
    # SelectedCells = intersect(rownames(results$scores), SelectedCells)
    # tempDF = tempDF[SelectedCells, ]
    # MetaFac = MetaFac[SelectedCells]
    
    CompName <- SDAComp_Name_Rx()
    
    tempDF2 = data.frame(SDAscore = datat[SelectedCells,CompName], 
                        Meta = naturalsort::naturalfactor(as.character(MetaFac)))
    
    
    
    GT = T
    CutThresh = as.numeric(input$SDAcutThr)
    print(CutThresh)
    tempDF2$GtThr = "BelowThreshold"
    
    
    if(GT) tempDF2$GtThr[tempDF2[,"SDAscore"]>=CutThresh] = "AboveThreshold"
    if(!GT) tempDF2$GtThr[tempDF2[,"SDAscore"]<CutThresh] = "AboveThreshold"
    
    
    pheatmap::pheatmap(asinh(chisq.test(table(tempDF2$Meta, tempDF2$GtThr))$res), 
                             clustering_method = "ward.D2")
    
    
    
    
  # }
  
  
})

Boxplot_GeneExprThr_Rx <- reactive({
  
  GeneExpr <- GeneExprDF_Rx()
  # SelectedCells = CellSelector()
  
  # print(head(GeneExpr))
  
  ggboxplot(subset(GeneExpr, GeneExpr > as.numeric(input$GeneThr)), 
            x = "Meta", y = "GeneExpr", 
            # palette = c(rep(col, LevLeng)),
            # add = "jitter", 
            fill="Meta", outlier.shape = NA) +
    geom_jitter(alpha=.2, size=.3) +
    theme_classic(base_size = 12) +
    ggtitle(input$Genetext) +
    xlab("") + ylab("Gene Expression")  +
    theme(legend.position="none",
          # legend.direction="horizontal",
          legend.title = element_blank(),
          axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
  
  
  
  
})

Barplot_GeneExprPercAbove_Rx  <- reactive({
  
  # SelectedCells = CellSelector()
  GeneExpr <- GeneExprDF_Rx()
  
  
  GeneExpr$percent_gt = GeneExpr %>%
    group_by(!!sym("Meta")) %>%
    mutate(num_gt_thr = sum(GtThr == "AboveThreshold"),
           percent_gt = num_gt_thr / n()) %>%
    ungroup() %>% pull(percent_gt) #%>% hist(breaks = 100)
  
  
  GeneExpr_red = GeneExpr[!duplicated(GeneExpr[,c("Meta", "GtThr")]),]
  GeneExpr_red = subset(GeneExpr_red, GtThr == "AboveThreshold")
  
  ggplot(GeneExpr_red, aes(x = Meta, y = percent_gt)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    labs(title = "Basic Bar Plot") + simplify2
  
  
  
  
})

ChrLocLoadings_Rx <- reactive({
  # print(input$SDAComp)
  

  geneLoadingVec = SDAComp_Selec_Rx()

  
  
    pgl <- genome_loadings(geneLoadingVec, 
                           label_both = T, 
                           max.items = as.numeric(input$NoOfGenes), 
                           gene_locations =   gene.locations,
                           chromosome_lengths = chromosome.lengths) + theme(aspect.ratio = .5)
    return(pgl)
    
  # }
})

SDAGOpos_Rx <- reactive({
  # geneLoadingVec = SDAComp_Selec_Rx()
  CompName <- SDAComp_Name_Rx()
  # names(goEnrichment)
  
  
  # if(! (as.numeric(input$ComponentNtext) %in% 1:100)){
  #   print("No GO")
  # } else {
  CompName2 = paste(gsub("sda_", "SDA",gsub("_V", "_",  gsub("\\.", "_", CompName))), "_Pos", sep="")
  # goEnrichment[[CompName2]]
  # 
  # CompName2 %in% names(goEnrichment)
  
  go_volcano_plot(x=goEnrichment, 
                    component = CompName2) + theme_classic(base_size = 10) + 
    theme(aspect.ratio = 1)
    
  # }
})

SDAGOneg_Rx <- reactive({
  # if(! (as.numeric(input$ComponentNtext) %in% 1:100)){
  #   print("No GO")
  # } else {
  CompName <- SDAComp_Name_Rx()
  CompName2 = paste(gsub("sda_", "SDA",gsub("_V", "_",  gsub("\\.", "_", CompName))), "_Neg", sep="")
  
    go_volcano_plot(x=goEnrichment, 
                    component = CompName2) + 
      theme_classic(base_size = 10)+ theme(aspect.ratio = 1)
    
  # }
})


ComboTopSDAgenes_DF_Rx <- reactive({
  geneLoadingVec = SDAComp_Selec_Rx()
  Out1 <- names(sort(geneLoadingVec, decreasing = T))[1:as.numeric(input$NoOfGenes)]
  Out1 <- names(sort(geneLoadingVec, decreasing = F))[1:as.numeric(input$NoOfGenes)]
  
  # Out1 <- print_gene_list(as.numeric(input$ComponentNtext), PosOnly = T) %>%
    #group_by(package) %>%
    #tally() %>%
    #arrange(desc(n), tolower(package)) %>%
    #mutate(percentage = n / nrow(pkgData()) * 100) %>%
    #select("Package name" = package, "% of downloads" = percentage) %>%
    # as.data.frame() %>% head(as.numeric(input$NoOfGenes))
  # Out1 <- Out1$Gene.Name
  
  # Out2 <- print_gene_list(as.numeric(input$ComponentNtext), NegOnly = T) %>%
    #group_by(package) %>%
    #tally() %>%
    #arrange(desc(n), tolower(package)) %>%
    #mutate(percentage = n / nrow(pkgData()) * 100) %>%
    #select("Package name" = package, "% of downloads" = percentage) %>%
    # as.data.frame() %>% head(as.numeric(input$NoOfGenes))
  # Out2 <- Out2$Gene.Name
  
  data.frame(Pos=Out1, Neg=Out2)
})
  