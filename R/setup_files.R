# This function will be called when the user invokes
# the New Project wizard using the project template defined in the template file
# at:
#
#   inst/rstudio/templates/project/rstudio_template.dcf

setup_files <- function(path, ...) {

  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # generate header
  header <- c(
    "---"
  )

  # collect inputs
  dots <- list(...)
  text <- lapply(seq_along(dots), function(i) {
    key <- names(dots)[[i]]
    val <- dots[[i]]
    paste0(key, ": ", val)
  })

  #needed for Rmarkdown file generation
  prj_type <- dots["prj_type"]
  title <- dots["title"]

  #needed for subdirectory creation
  create_dirs <- dots["create_dirs"]

  # collect into single text string
  contents <- paste(
    paste(header, collapse = "\n"),
    paste(text, collapse = "\n"),
    sep = "\n"
  )

  # write to log file
  writeLines(contents, con = file.path(path, "creation_log"))

  rmarkdown::draft(paste0(title,".Rmd"), template = "boilerplate", package = "basicTemplate", edit = F, create_dir = T)

  if(prj_type == "16S") {
    temp <- readLines(con = file.path(title,"mother_qiime2_TagSequencingReport.Rmd"))
    actual_report <- paste(
      paste(contents, collapse = "\n"),
      paste(temp[4:length(temp)], collapse = "\n"),
      sep = "\n"
    )
    writeLines(actual_report, con = file.path(path, paste0(title,".Rmd")))
  }

  if(prj_type == "WGS") {
    temp <- readLines(con = file.path(title,"mother_shotgun_report.Rmd"))
    actual_report <- paste(
      paste(contents, collapse = "\n"),
      paste(temp[4:length(temp)], collapse = "\n"),
      sep = "\n"
    )
    writeLines(actual_report, con = file.path(path, paste0(title,".Rmd")))
  }

  log_path <- file.path(path, "error_log")
  log_fh <- file(log_path, "w+")

  #copy all the supporting files from the template
  system2(command = "cp", args = c("-R", "-n", paste0(file.path(title), "/* "), file.path(path)), stderr = log_fh)

  #remove the originals (unless you want a lot of unnecessary clutter!)
  system2(command = "rm", args = c("-r", "-f", file.path(title)), stderr = log_fh)

  # try(unlink(file.path(title), recursive = T, force = T), outFile = file.path(path, "delete_log"))

  if(create_dirs == TRUE) {

    dir.create(file.path(path, "Data"), showWarnings = F)
    dir.create(file.path(path, "Output"), showWarnings = F)
    dir.create(file.path(path, "Scripts", "Functions"), showWarnings = F, recursive = T)
    dir.create(file.path(path, "Scripts", "HPC_cluster"), showWarnings = F, recursive = T)
    dir.create(file.path(path, "Scripts", "Rmds"), showWarnings = F, recursive = T)

  }

  system2(command = "mv", args = c(file.path(path,"*.Rmd"), file.path(path, "Scripts", "Rmds")), stderr = log_fh)
  system2(command = "mv", args = c(file.path(path,"toc_after.tex"), file.path(path, "Scripts", "Rmds")), stderr = log_fh)
  system2(command = "mv", args = c(file.path(path,"TeX_packages_commands.sty"), file.path(path, "Scripts", "Rmds")), stderr = log_fh)
  system2(command = "mv", args = c(file.path(path,"*.R"), file.path(path, "Scripts", "Functions")), stderr = log_fh)
  system2(command = "mv", args = c(file.path(path,"logo_blk.png"), file.path(path, "Scripts", "Rmds")), stderr = log_fh)

  close(log_fh)

}
