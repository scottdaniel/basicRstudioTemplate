# rstudio_template
Rstudio template for the Penn CHOP Microbiome Program

## !This relies on the installation of: https://github.research.chop.edu/MicrobiomeCenter/basicTemplate!

## Install
```
if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github(repo = "MicrobiomeCenter/rstudio_template", host = "github.research.chop.edu/api/v3")
```
## Usage
Once installed, you can create a new PCMP R project from the dialog in Rstudio: `File > New project...`
Then, just select the `New Directory > PCMP Rstudio Template`

Finally, fill in the project name, author, and the project type.

The project type is important because it gives you the starting R markdown file.

The new project will also have the following standardized directory structure (if `Create directory structure` is checked):
```
Data
Output
Scripts
  |--Functions
  |--HPC_cluster
  |--Rmds
```

### References
https://rstudio.github.io/rstudio-extensions/rstudio_project_templates.html

