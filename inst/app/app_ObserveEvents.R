# observeEvent(input$SDArun, {
# 
#   if(as.character(input$SDArun)=="SDA561999"){
#     source("app_loadFxs_b.R", local = TRUE)
#     print("SDA561999 loaded")
#   }
#   
#   if(as.character(input$SDArun)=="SDA583600"){
#     source("app_loadFxs_a.R", local = TRUE)
#     print("SDA583600 loaded")
#   }
#   
# })

observeEvent(input$NextSDA, {
  Val <- as.character(min(c(150, as.numeric(input$ComponentNtext)+1)))
  
  updateTextInput(session, "ComponentNtext", value = Val)
})

observeEvent(input$PrevSDA, {
  Val <- as.character(max(c(1, as.numeric(input$ComponentNtext)-1)))
  
  updateTextInput(session, "ComponentNtext", value = Val)
})
# observeEvent(input$ScreenShot, {
#   screenshot()
# })



observeEvent(input$C2Cpos, {
  
  
  Out1 <- print_gene_list(as.numeric(input$ComponentNtext), PosOnly = T) %>%
    #group_by(package) %>%
    #tally() %>%
    #arrange(desc(n), tolower(package)) %>%
    #mutate(percentage = n / nrow(pkgData()) * 100) %>%
    #select("Package name" = package, "% of downloads" = percentage) %>%
    as.data.frame() %>%
    head(as.numeric(input$NoOfGenes)) 
  Out1 <- Out1$Gene.Name
  
  # print(Out1)
  clipr::write_clip(Out1)
  
})

observeEvent(input$C2Cneg, {
  
  
  Out2 <- print_gene_list(as.numeric(input$ComponentNtext), NegOnly = T) %>%
    #group_by(package) %>%
    #tally() %>%
    #arrange(desc(n), tolower(package)) %>%
    #mutate(percentage = n / nrow(pkgData()) * 100) %>%
    #select("Package name" = package, "% of downloads" = percentage) %>%
    as.data.frame() %>%
    head(as.numeric(input$NoOfGenes)) 
  Out2 <- Out2$Gene.Name
  
  # print(Out1)
  clipr::write_clip(Out2)
  
})

output$TXTall <- downloadHandler(
  filename = function(){
    paste("data-TopGenes_SDA_negNpos", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    # print(ComboTopSDAgenes_DF_Rx())
    write.csv(ComboTopSDAgenes_DF_Rx(), file, row.names=F)
    # write.table(paste(text,collapse=", "), file,col.names=FALSE)
  }
)