library(officer)
library(rstudioapi)

# https://stackoverflow.com/questions/3452086/getting-path-of-an-r-script
this_file = rstudioapi::getActiveDocumentContext()$path
path = box::file()
check_path = unlist(strsplit(this_file, split = "/"))
check_path = paste0(check_path[1:length(check_path)-1], collapse="/")
if (check_path != path){warning("There might be issues related to the path of files.", call. = TRUE, immediate. = FALSE, domain = NULL)}

source(file.path(path, "inject.r"))

setwd(file.path(path, "docs"))
allfiles = dir()
print(allfiles)

doreaddocx = function(varin){
  varin = read_docx(varin) |> docx_summary()
  varout = capture.output(cat(varin$text))
  return(varout)
}

docx_files_jne = list.files(pattern="*.docx", full.names=F)
docx_inhalte_jne = lapply(docx_files_jne, doreaddocx)

#-------------------------#

df_names = c("id", "name", "age")
checkout_df = data.frame(matrix(ncol = length(df_names), nrow = 10))
colnames(checkout_df) = df_names

