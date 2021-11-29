# available 1.0.5

* Gábor Csárdi is now the maintainer.

* `get_wikipidia()` renamed to `get_wikipedia()`.

* `valid_package_name()` now correctly checks a package name according to CRAN policy (@KevCaz, #61).

# available 1.0.4

* Tests requiring network access are now skipped on CRAN.

# available 1.0.3

* `BiocManager` is now preferred to `BiocInstaller` if both are installed (#44, @luciorq).

* `create()` now uses `usethis::create_package()` rather than the deprecated `devtools::create()`.

# available 1.0.2

* Add dialog when run interactively asking if urban dictionary results should
  be included, as they can potentially contain offensive results (#41).
* Use BiocManager for compatibility with future versions of R.

# available 1.0.1

* Filter own repo from GitHub results (#21).
* `get_urban_data()` is now exported (#34).
* No longer trimming r or R when proceeded by a vowel from search terms, as originally intended (#35).
* Support for upcoming glue 1.3.0 release

# available 1.0.0

* Initial release
