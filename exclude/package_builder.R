usethis::use_directory("exclude", ignore = TRUE)
usethis::use_build_ignore("exclude")
usethis::use_build_ignore("setops.Rproj")
usethis::use_package("rlang", "Suggests")
usethis::use_gpl3_license("GPL-3")
usethis::use_git()

shell("git remote add origin https://github.com/moodymudskipper/rangeops.git",intern = TRUE)
shell("git push -u origin master -f",intern = TRUE)

remotes::install_github("moodymudskipper/rangeops")

# to do
usethis::use_readme_rmd()
usethis::use_testthat()
usethis::use_version()
usethis::use_news_md()
