#geneID <- c("APOE", "KL", "EGFR", "APP"); IDtype = "external_gene_name"; organism = "human"; gene.info.file = "~/Desktop/gene_info.txt"

get_gene_info <- function(geneID = c("Egfr", "Kl", "App", "Apoe"), 
    IDtype = "external_gene_name", organism = "mouse",
    gene.info.file = "gene_info.txt"){
  
  if(!file.exists(gene.info.file)){
    library(biomaRt)
    all.var <- ls()

    lib.loaded <- as.logical(length(which(all.var == "ens.lib")))

        if(!lib.loaded){
            if(organism == "mouse"){
                ens.lib <- useEnsembl(biomart="ensembl", dataset="mmusculus_gene_ensembl")
            }else{
                ens.lib <- useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")
            }
            #att <- listAttributes(ens.lib)
            #fil <- listFilters(ens.lib)
            #head(att)
            }
    
        gene.info <- getBM(c("ensembl_gene_id", "external_gene_name", 
            "entrezgene_id", "chromosome_name", "start_position", "end_position"), 
            IDtype, geneID, ens.lib)
        write.table(gene.info, gene.info.file, quote = FALSE, row.names = FALSE, sep = "\t")
    }else{
        gene.info <- read.delim(gene.info.file)
    }

    return(gene.info)

}
