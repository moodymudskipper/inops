## Test environments
* local OS X install, R 3.6.1
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## incoming checks issue 2019-11-08

cran-comments.md wasn't added to .Rbuildignore and it resulted in a note, now fixed.

## Response to Jelena Saf's comments 2019-11-13

> If there are references describing the methods in your package, please
> add these in the description field of your DESCRIPTION file in the
> form authors (year) doi:... authors (year) arXiv:... authors (year,
> ISBN:...) or if those are not available: https:... with no space after
> 'doi:', 'arXiv:', 'https:' and angle brackets for auto-linking.

We are not entirely sure what this is refering to, but we added fields `URL:`
and `BugReports` in case it helps. This package does not reference academic publications.


