
# 583600
# 561999

# if (Sys.getenv("SCRATCH_DIR") != "") {
# 
#   pathi = paste0(Sys.getenv("SCRATCH_DIR"), "/data")
#   load.data.path = paste0(pathi, "/GillLab/BASSAA/SDA561999obj.rds" )
# }  else {
#   load.data.path = paste0(pathi, "/SDA561999obj.rds" )
# 
#   if(!file.exists(load.data.path)) {
#     load.data.path = paste0(pathi, "/data/SDA561999obj.rds" )
# 
#   }
# 
# }

filename = "minimal_data_dec_04_2024_noGEX.rds"
load.data.path <<- paste0(pathi, "/inst/app/data/", filename )

if(file.exists(load.data.path)) {
  
} else {
  load.data.path <<- paste0(pathi, "/data/",filename )
   
}


list2env(readRDS(load.data.path), envir = globalenv())



# table(datat$Status)
# table(datat$Status2)

datat$Cond1[datat$Status2=="AXI"] = "AS"
datat$Cond1[datat$Status2=="HC" & datat$Origin=="Downloaded" ] = "HC"

# table( datat$Cond1)
# sum(is.na( datat$Cond1))
datat[is.na( datat$Cond1), ]


# table( datat$Cond2)

datat$Cond2 = datat$Status
datat$Sex[is.na(datat$Sex)] = "Unk"
datat$B27pos[is.na(datat$B27pos)] = "Unk"

 # datat$Cond1 = "other"

# table(datat$SubjectId2)
# sum(is.na(datat$SubjectId2))

# datat$Cond1[datat$SubjectId %in% c("BRM526", "BRM527", "BRM545", "BRM632", "BRM719")] = "HC_B27+"
# datat$Cond1[datat$SubjectId %in% c("BRM630", "BRM542", "BRM535", "BRM584", "BRM333")] = "HC_B27-"
# datat$Cond1[datat$SubjectId %in% c("BRM533", "BRM467", "BRM656", "BRM489", "BRM814")] = "AS_B27+"
# datat$Cond1[datat$SubjectId %in% c("BRM659", "BRM657", "BRM677", "BRM103", "BRM493")] = "AS_AAU_B27+"
# datat$Cond1[datat$SubjectId %in% c("BRM708", "UGE337", "BRM561", "BRM851", "UGE054")] = "AAU_B27+"
# table(datat$Cond1)

# AllCells = KeepCells

# clipr::write_clip(names(table(datat$Cond1)))
# pathi = paste0(getwd(), "/inst/app")


# source("app_NewComps.R",local = TRUE)

# DataMetaDF <- data.frame(objID= c(561999L, 566999L, 567045L, 567128L,
#                                  567598L, 567665L, 568818L, 568833L,
#                                  568860L, 569511L, 569646L,
#                                  583600L),
#                         ObjName= c("Full_DS60K", "Minor Clusters", "Bcells",
#                                    "TNK_sub3", "TNK_sub0_DS50K2",
#                                    "TNK_sub0_DS55K", "TNK_sub2_DS50K",
#                                    "Myeloids_DS50K",
#                                    "TNK_sub0_DS50K", "Bcells_clean", "Mcells_clean",
#                                    "Full_clean_DS75K") )
# rownames(DataMetaDF) = paste0("sda.", DataMetaDF$objID)
# 
# colnames(results$scores) = paste0("sda.561999.", colnames(results$scores))
# rownames(results$loadings[[1]]) = colnames(results$scores)
# 
# UMAP_SerSubs <- rbind(readRDS(paste0(pathi, "/data/Bcell_UMAP.rds")),
#                       readRDS(paste0(pathi, "/data/Mcell_UMAP.rds")),
#                       readRDS(paste0(pathi, "/data/TNKcell_UMAP.rds")))  %>% as.data.frame()
# 
# UMAP_SerSubs = UMAP_SerSubs[intersect(rownames(UMAP_SerSubs), rownames(UMAP_CS_All)),]

# datat[,c("rpcar1umap_1", "rpcar1umap_2")]



list2env(list(datat = datat,
              SDAls = list(sda.561999 = sda.561999.loading, sda.583600=sda.583600.loading)), 
         envir = globalenv())



# remove(sda.561999.loading, sda.583600.loading)