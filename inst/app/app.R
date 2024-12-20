# B27 Ankylosing Spondylitis and Acute Anterior Uveitis Atlas (BASSAA)

# BASSAA -----

## libraries -----
library(shiny)
library(rclipboard)
library(shinydashboard)


library(ggplot2)
library(ggridges)
library(data.table)
library(ggrepel)
library(viridis)
library(ggnewscale)
library(RColorBrewer)
library(grid)
library(gridExtra) 
require(dplyr)
library(ggrastr)


library(ggpubr)

library(DT)
library(knitr)


# library(BASSAA)


VersionID = "0.4.0"
## TODO Use the results list to update it with multiple SDAs


## Inputs -----
pathi <<- getwd()

source("app_Fxs.R",local = TRUE)

DownSampN = 10000


## Palettes -----

# palettes <- ggthemes::ggthemes_data[["tableau"]][["color-palettes"]][["regular"]]$`Tableau 20`$value

# col_vector = c("#7FC97F", "#38170B", "#BEAED4", "#BF1B0B", "#FFC465", "#386CB0", 
#                "#66ADE5", "#F0027F", "#252A52", "#BF5B17", "#999999", "#666666", 
#                "#E69F00", "#1B9E77", "#7570B3", "#F0E442", "#B07AA1", "#F28E2B", 
#                "#FFBE7D", "#59A14F", "#8CD17D", "#B6992D", "#F1CE63", "#499894", 
#                "#86BCB6", "#E15759", "#FF9D9A", "#79706E", "#BAB0AC", "#D37295", 
#                "#FABFD2", "#E7298A", "#D4A6C8", "#9D7660", "#D7B5A6","#e6194b", 
#                "#666666", "#3cb44b", "#A6CEE3", "#ffe119", "#1F78B4", "#B15928")

col_vector <- c(
  "#7FC97F", "#38170B", "#BEAED4", "#BF1B0B", "#FFC465", "#386CB0",
  "#66ADE5", "#F0027F", "#252A52", "#BF5B17", "#999999", "#666666",
  "#E69F00", "#1B9E77", "#7570B3", "#F0E442", "#B07AA1", "#F28E2B",
  "#FFBE7D", "#59A14F", "#8CD17D", "#B6992D", "#F1CE63", "#499894",
  "#86BCB6", "#E15759", "#FF9D9A", "#79706E", "#BAB0AC", "#D37295",
  "#FABFD2", "#E7298A", "#D4A6C8", "#9D7660", "#D7B5A6", "#e6194b",
  "#666666", "#3cb44b", "#A6CEE3", "#ffe119", "#1F78B4", "#B15928",
  "#A6D854", "#FD8D3C", "#8C564B", "#FF9896", "#C49C94", "#9467BD",
  "#C5B0D5", "#17BECF", "#B2DF8A", "#FB8072", "#FDB462", "#80B1D3",
  "#B3DE69", "#FCCDE5", "#BC80BD", "#CCEBC5", "#FFED6F", "#A6761D",
  "#E6AB02", "#A9A9A9", "#6A3D9A", "#BFD3E6", "#FDC086", "#E78AC3",
  "#C2A5CF", "#1B7837", "#762A83", "#A6CEE3", "#2B8CBE", "#E41A1C",
  "#F781BF", "#8DD3C7", "#FB9A99", "#BC80BD", "#FF7F00", "#FFFFB3",
  "#984EA3", "#A65628", "#F7F7F7"
)
# UI -----



ui <- dashboardPage(
  dashboardHeader(title = paste0("BASSAA v", VersionID)),
  
  ## Dashboard -----
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home Page", tabName = "homepage", icon = icon("home"),
               badgeLabel = "final", badgeColor = "green"),
      menuItem("Main tab", tabName = "maintab", icon = icon("star"),
               badgeLabel = "final", badgeColor = "green"),
      menuItem("User Manual", tabName = "usermanual", icon = icon("plus"),
               badgeLabel = "final", badgeColor = "green"),
      menuItem("Version History", tabName = "versionhistory", icon = icon("plus"),
               badgeLabel = "final", badgeColor = "green"),
      menuItem("Cite Me", tabName = "citation", icon = icon("plus"),
               badgeLabel = "final", badgeColor = "green"),
      menuItem("Gill Lab", icon = icon("book"), 
               href = "https://www.ohsu.edu/school-of-medicine/gill-lab"),
      menuItem("@eisamahyari", icon = icon("heart"), 
               href = "https://eisascience.github.io")
    )
  ),
  
  
  ## Dash Body -----
  

  dashboardBody(
    
    ### Tab Items -----
    
    tabItems(
      
      #### template tabs
 
      
      
     ### homepage  -----
      tabItem(tabName = "homepage",
              
              fluidRow(
                h2("Welcome to BASSAA's Homepage"),
                box(
                  title = "About BASSAA", status = "primary", solidHeader = TRUE,
                  
                  p("BASSAA (B27 Ankylosing Spondylitis and Acute Anterior Uveitis Atlas) provides a comprehensive exploration of immune signatures underlying Ankylosing Spondylitis (AS) and Acute Anterior Uveitis (AAU). These diseases share a strong genetic association with HLA-B27 and exhibit overlapping yet distinct immune mechanisms."),
                  p("Using single-cell CITE sequencing, BASSAA uncovers transcriptomic and immunophenotypic differences across AS, AAU, and HLA-B27 positive and negative healthy controls. Key highlights include dysregulated immune pathways, B-cell maturation defects in AS, and cytotoxic TNK cell enrichment in AAU."),
                  p("Dive into the Main Tab to explore SDA-derived components, including Myeloid Regulation Imbalance (MRI), B-Cell Defect Signature (BCDS), and TNK Cytotoxic Module (TCM). Gain insights into the distinct and shared mechanisms driving these conditions."),
                  width = 12
                ),
                
                box(
                  title = "Learn More", status = "info", solidHeader = TRUE,
                  
                  p("Visit the 'User Manual' tab for step-by-step guidance, or explore the 'Version History' to see updates."),
                  p("For further information, visit the 'Cite Me' tab to view publication details or contact the development team."),
                  width = 12
                ),
                
                box(
                  title = "Manuscript in Review", status = "warning", solidHeader = TRUE,
                  
                  p("As of Dec 2024, the manuscript detailing BASSAA's findings is currently in review. Below are the authors and title:"),
                  p("Mahyari, E., Davin, S., Ogle, K., Fale-Olsen, E., Shaut, C., Martin, T.M., Ahuja, J., Suhler, E., Deodhar, A., Rosenbaum, J., & Gill, T. (In Review). \"Divergent B cell and cytotoxic TNK cell activation signatures in HLA-B27-associated ankylosing spondylitis and acute anterior uveitis\"."),
                  width = 12
                ),
                
                box(
                  title = "Shiny App Dev", status = "success", solidHeader = TRUE,
                  
                  p("This Shiny App (BASSAA) has been produced and designed by Eisa Mahyari Ph.D.\ Please report bugs, issues, update requests, etc to Eisa."),
                  p("Last update Dec 2024"),
                  width = 12
                ),

                imageOutput("homepage", width = 900)
              )
      ),

      
      
      ###  main tab -----
      
      # First
      tabItem(tabName = "maintab",
              fluidRow(
                h2("Main Tab"),
                valueBoxOutput("SDACompOrigin", width = 10),
                
                
               
                
                ### Viz Inputs ------
                box(
                  title = "Visualization Inputs", status = "warning", solidHeader = TRUE,
                  
                  radioButtons("DimRedux", "2DReduction:",
                               c(
                                 # "UMAPintg - M-G" = "rpca_intg_UMAP_MGonly",
                                 # "UMAPintg - GSE194315" = "rpca_intg_UMAP_GSEonly",
                                 "UMAPintg" = "rpca_intg_UMAP_both"
                                 
                                 # "tSNE - Full SDA-CellScores" = "full_tSNE_SDA_CS",
                                 # "UMAP - Full SDA-CellScores" = "full_UMAP_SDA_CS",
                                 # "tSNE - Batch-removed SDA-CellScores" = "clean_tSNE_SDA_CS",
                                 # "UMAP - Batch-removed SDA-CellScores" = "clean_UMAP_SDA_CS",
                                 # "UMAP - Seurat based Per Cell Type" = "ser_umap_perCT"
                               ), selected = "rpca_intg_UMAP_both"),
                  radioButtons("originselect", "Data Origin:",
                               c("Mahyari-Gill" = "tejpal",
                                 "GSE194315" = "gse194315",
                                 "both" = "both"
                               ), selected = "tejpal"),
                  radioButtons("metaselect", "Metadata Selection:",
                               c("Major Cell Types" = "majorcelltype",
                                 "Immunophenotypes" = "azimuthl2",
                                 # "Azimul.L3" = "azimuthl3",
                                 "Donors" = "subjectid",
                                 "Condition1" = "condid1",
                                 "Condition2" = "condid2",
                                 "Sex" = "sex",
                                 "HLA-B27" = "b27"#,
                                 # "CellCycle" = "phase"
                               ), selected = "azimuthl2"),
                  width = 3
                ) ,
                
                
                box(
                  title = "Cell Selection Inputs", status = "warning", solidHeader = TRUE,
                  radioButtons("condiselect", "Condition :",
                               c("HC only" = "hconly",
                                 "AS HC" = "as_hc",
                                 "AAU HC" = "aau_hc",
                                 "AS_AAU HC" = "asaau_hc",
                                 "All" = "all"
                               ), selected = "all"),
                  radioButtons("mctselect", "Major Cell Type:",
                               c("TNKs" = "tnks",
                                 "Myeloids" = "myeloids",
                                 "Bcells" = "bcells",
                                 "TNK_B" = "tnkb",
                                 "TNK_M" = "tnkm",
                                 "M_B" = "mb",
                                 "All" = "all"
                               ), selected = "bcells"),
                  width = 3
                ),
                
                
                ### SDA Inputs ------
                
                box(
                  title = "SDA Inputs", status = "warning", solidHeader = TRUE,
                  # textInput("ComponentNtext", "SDA component search (numerical):", "1"),
                  selectInput("SDAComp", 
                              label = "Select an SDA Component:", 
                              choices = c(
                                
                                "B-Cell Defect (BCD)",
                                "Myeloid regulation imbalance (MRI)",
                                "pDC-monocyte differential (PMD)",
                                "TNK Cytotoxic Module (TCM)"
                              ), 
                              selected = 1), 
                  textInput("SDAcutThr", "SDA Score Threshold", "0"),
                  # actionButton("PrevSDA", "Prev SDA"),
                  # actionButton("NextSDA", "Next SDA"),
                  textInput("NoOfGenes", "No. of Genes to output:", "30"),
                  actionButton("C2Cpos", "CopyPosGenes (local)"),
                  actionButton("C2Cneg", "CopyNegGenes (local)"),
                  downloadButton("TXTall", "DownloadGenes (any browser"),
                  width = 6
                ) ,
                
                
                ### Gene Inputs ------
                
                # box(
                #   title = "Gene Inputs", status = "warning", solidHeader = TRUE,
                #   textInput("Genetext", "Gene search (text input):", "S100A11"),
                #   textInput("GeneThr", "Gene Expression Threshold", "0.1"),
                #   width = 6
                # ) ,
                
                ### Cell Inputs ------
                
               
                
                ### Viz ---- 
                
                #### Chro Loc ---- 
                
        
                box(
                  title = "Chrom. Location", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  downloadButton("ChrLoc_download"),
                  plotOutput("ChrLoc"),
                  width = 10
                ), 
                
                #### Cell Score (Ridge) ---- 
                
              
              box(
                title = "Cell Score (Ridge)", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                downloadButton("RidgeSDAScore_download"),
                plotOutput("Ridge_SDAScoreProj"), #plotlyOutput
                width = 5
              ), 
              
              #### heatmap SDA Enrichment  ---- 
              
              box(
                title = "Enrichment N cells with Score > Thr", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                downloadButton("HeatmapSDAScore_download"),
                plotOutput("Heatmap_SDAScoreThr"), #plotlyOutput
                width = 5
              ), 
              
              #### GO neg ---- 
              
              box(
                title = "GO negative", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                downloadButton("SDAGOneg_download"),
                plotOutput("GOneg"), #plotlyOutput
                width = 5
              ),
              
              #### GO pos ---- 
              box(
                title = "GO positive", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                downloadButton("SDAGOpos_download"),
                plotOutput("GOpos"), #plotlyOutput
                width = 5
              ),
              
              #### Cell Score 2D ---- 
              box(
                title = "Cell Score (2D)", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                downloadButton("UMAPscoreProj_download"),
                plotOutput("DimRedux_SDAScoreProj"), #plotlyOutput
                width = 5
              ),
              
              # #### Gene Expr 2D ---- 
              # box(
              #   title = "Gene Expression (2D)", status = "primary", solidHeader = TRUE,
              #   collapsible = TRUE,
              #   downloadButton("UMAPgeneExpr_download"),
              #   plotOutput("DimRedux_geneExpr"), #plotlyOutput
              #   width = 5
              # ),
              # 
              # #### Percent Cells GT thr ---- 
              # box(
              #   title = "Percent Cells > Gene Expr Threshold", status = "primary", solidHeader = TRUE,
              #   collapsible = TRUE,
              #   # downloadButton("tSNEwMeta_download"),
              #   plotOutput("Barplot_GeneExprPercAbove"), #plotlyOutput
              #   width = 5
              # ),
              # 
              # #### Boxplot Gene Expression thr ---- 
              # box(
              #   title = "Gene Expression (Thresholded)", status = "primary", solidHeader = TRUE,
              #   collapsible = TRUE,
              #   downloadButton("Boxplot_GeneExprThr_download"),
              #   plotOutput("Boxplot_GeneExprThr"), #plotlyOutput
              #   width = 5
              # ),
              
              #### Metadata 2D ---- 
              box(
                title = "Metadata (2D)", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                # downloadButton("tSNEwMeta_download"),
                plotOutput("DimRedux_Meta"), #plotlyOutput
                width = 5
              ),
              
              #### Metadata Legend ---- 
              
              box(
                title = "Metadata Legend", status = "primary", solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("DimRedux_MetaLegend"),
                width = 5
              ),
              
              ### Top Loaded Gene Tables ---- 
              
              box(title = "Pos. Top Genes", status = "info", solidHeader = TRUE, width = 4,
                  tableOutput("packageTablePos")
              ),
              box(title = "Neg. Top Genes", status = "info", solidHeader = TRUE, width = 4,
                  tableOutput("packageTableNeg")
              )
              
      )
      
      
      
      
      ),#tabitem
      
      ### versionhistory  -----
      
      tabItem(tabName = "versionhistory",
              h2("Version History"),
              fluidRow(
                uiOutput('VerHistHTML')
                
                
              )
      ),
      
     ### citation  -----
     
     tabItem(tabName = "citation",
             h2("BASSAA Citation"),
             fluidRow(
               uiOutput('CiteMeHTML')
               
               
             )
     ),
     
      
      ### usermanual -----
      
      tabItem(tabName = "usermanual",
              h2("User Manual"),
              fluidRow(
                uiOutput('UserManualHTML')
                
                
              )
      )
    )#tabitems
  )#dashboardBody
  
  
)#dashboardPage


# Server -----

server <- function(input, output, session) {
  
  source("app_loadFxs.R", local = TRUE)
  
  
  source("app_server.R",local = TRUE)
  
  ################################ Reactive sections-----
  source("app_Reactive.R",local = TRUE)
  
  ################################ observeEvent sections-----
  source("app_ObserveEvents.R",local = TRUE)
  
  ################################ renderPlot sections-----
  source("app_RenderPlots.R",local = TRUE)
  
  ################################ Download Buttons sections-----
  source("app_DownloadButtons.R",local = TRUE)
  
  output$VerHistHTML <- renderUI({
    # paste0(pathi, "/data/HISTAv1_dataLS_feb2022.rds")
    # HTML(markdown::markdownToHTML(knit('VersionHistory.md', quiet = TRUE)))
    includeHTML('VersionHistory.html')
  })
  
  output$UserManualHTML <- renderUI({
    # paste0(pathi, "/data/HISTAv1_dataLS_feb2022.rds")
    # HTML(markdown::markdownToHTML(knit('VersionHistory.md', quiet = TRUE)))
    includeHTML('UserManual.html')
  })
  
  output$CiteMeHTML <- renderUI({
    # paste0(pathi, "/data/HISTAv1_dataLS_feb2022.rds")
    # HTML(markdown::markdownToHTML(knit('VersionHistory.md', quiet = TRUE)))
    includeHTML('CiteMe.html')
  })

  
}


shinyApp(ui, server)

