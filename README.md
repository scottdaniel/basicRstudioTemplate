# rstudio_template
Rstudio template for the basic bioinformatics of microbiomes

## !This relies on the installation of: https://github.com/scottdaniel/basicTemplate!

## Install
```
if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github(repo = "scottdaniel/basicRstudioTemplate")
```
## Usage
Once installed, you can create a new  R project from the dialog in Rstudio: `File > New project...`
Then, just select the `New Directory > Rstudio Template`

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

