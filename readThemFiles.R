library(officer)
library(rstudioapi)
library(pdftools)
library(readxl)


# https://stackoverflow.com/questions/3452086/getting-path-of-an-r-script
this_file = rstudioapi::getActiveDocumentContext()$path
path = box::file()
check_path = unlist(strsplit(this_file, split = "/"))
check_path = paste0(check_path[1:length(check_path)-1], collapse="/")
if (check_path != path){warning("There might be issues related to the path of files.", call. = TRUE, immediate. = FALSE, domain = NULL)}

tryCatch({
  source(file.path(path, "insert.r"))
},
error = function(e) {
  cat("Error: ", conditionMessage(e), "\n")
},
warning = function(w) {
  cat("Warning: ", conditionMessage(w), "\n")
}
)

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

##-------- PDFs ------------#
require(pdftools)
get_pdf_txt = pdf_text(allfiles[2])
cat(get_pdf_txt)
##--------------------------#


##-------- xlsx ------------#
require(readxl)
xlsx_files_jne = list.files(pattern="*.xlsx", full.names=F)
one_xlsx_file = xlsx_files_jne[1]
xlsx2df = read_xlsx(one_xlsx_file, encoding="UTF-8")
##--------------------------#



