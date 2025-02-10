library(officer)
library(here)

path = file.path(here(), "docs/")
setwd(path)
allfiles = dir(path)

doreaddocx = function(varin){
  varin = read_docx(varin) |> docx_summary()
  varout = capture.output(cat(varin$text))
  return(varout)
}

'
file = "example.docx"
this_file = file.path(path, file)
content = read_docx(this_file) |> docx_summary()
rawtxt = capture.output(cat(content$text))
rawtxt
'

#-------------------------#

docx_files_jne = list.files(pattern="*.docx", full.names=F)
docx_inhalte_jne = lapply(docx_files_jne, doreaddocx)


