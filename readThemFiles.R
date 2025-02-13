library(officer)
library(rstudioapi)

# https://stackoverflow.com/questions/3452086/getting-path-of-an-r-script
this_file = rstudioapi::getActiveDocumentContext()$path
path = box::file()
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

