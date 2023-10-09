# HIV-1_DR_RJ_Analysis: HIV-1 Drug Resistance Reporting from JSON files

## Overview
This tool was created in collaboration with sequencing staff (James McKenna, Lesley Neill, Derek Fairley, Tanya Curran) at the BHSCT Regional Virology Laboratory, Belfast, to produce bespoke HIV-1 drug resistant clinical reports containing both patient information and Stanford's University HIV-1 resistance database [HIVdb](https://hivdb.stanford.edu/hivdb/by-reads/) interpretation to help our clinicians in patient management of HIV-1 infection.

Although 'raw JSON report' outputs are available following submission of paired FASTQs to the HIVdb-NGS pipeline, these are not in a user friendly format for our clinical colleagues. Therefore using an overarching R script `HIV_resistance_report_online_only.R`(overview below), different bespoke clinical reports (created by `R Markdown` scripts) are generated based on the suffix following the lab number.

![](https://github.com/BHSCT-Bioinformatics/HIV-1_DR_RJ_Analysis/blob/main/Clinical_report_generation_workflow_v2.drawio.png?raw=true)

## Installation

Clone the HIV-1_DR_RJ_Analysis folder into your working directory

`git clone https://github.com/BHSCT-Bioinformatics/HIV-1_DR_RJ_Analysis.git`

## Usage


### Dependencies
This tool is dependent on various R packages (currently tested with R version 4.3.1) which are all available on [CRAN](https://cran.r-project.org/)
- [rmarkdown 2.23](https://cran.r-project.org/web/packages/rmarkdown/index.html)
- [knitr 1.43](https://cran.r-project.org/web/packages/knitr/index.html)
- [plyr 1.88](https://cran.r-project.org/web/packages/plyr/index.html)
- [dplyr 1.12](https://cran.r-project.org/web/packages/dplyr/index.html)
- [tidyr 1.30](https://cran.r-project.org/web/packages/tidyr/index.html)
- [tidyjson 0.32](https://cran.r-project.org/web/packages/tidyjson/index.html)
- [tinytex 0.45](https://cran.r-project.org/web/packages/tinytex/index.html)
- [readxl 1.43](https://cran.r-project.org/web/packages/readxl/index.html)


## Author
- Marc Niebel (Bioinformatician at Regional Virology Laboratory, Belfast)
- Email address: Marc.Niebel@belfasttrust.hscni.net

