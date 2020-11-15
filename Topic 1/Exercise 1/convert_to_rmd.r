
library(rmarkdown)

# Generate Paths
spt_file_root = './'
spt_file_name = 'Exercise_1'
spt_file_full_ipynb = paste0(spt_file_root, spt_file_name, '.ipynb')
spt_file_full_rmd = paste0(spt_file_root, spt_file_name, '.rmd')

# Convert from IPYNB to RMD
file_nb_rmd = rmarkdown:::convert_ipynb(spt_file_full_ipynb)
st_nb_rmd = xfun::file_string(file_nb_rmd)

# Save RMD
fileConn <- file(spt_file_full_rmd)
writeLines(st_nb_rmd, fileConn)
close(fileConn)

