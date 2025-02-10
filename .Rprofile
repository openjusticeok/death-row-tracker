## Allows the use of a global .Rprofile while also using renv
# Check if HOME environment variable is set
home_dir <- Sys.getenv("HOME")
if (home_dir != "") {
  # Check if the global .Rprofile exists and source it
  global_rprofile <- file.path(home_dir, ".Rprofile")
  if (file.exists(global_rprofile)) {
    source(global_rprofile)
  }
  rm(home_dir, global_rprofile)
} else {
  warning("HOME environment variable is not set. Global .Rprofile not sourced.")
}
