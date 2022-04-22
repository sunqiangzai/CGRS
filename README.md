# CGRS
We established a new prognostic signature, clinic and genetic risk score (CGRS), by integrating gene expression profiles with clinical characteristics. CGRS has been confirmed in four different cohorts for accurately predicting GC prognosis, and significantly stratified stage III GC patients into high and low risk groups with different survival time. Furthermore, an easy-to-use nomogram and web application based on CGRS were developed to facilitate its application in clinical practice.


# Script
In this folder, the scripts used to array data processing, perform permutations, identify prognostic genes, and build prognositic models were provided.
| Script  | Function |
| ------------- | ------------- |
| Prognostic_genes.R  | identify prognostic genes  |
| summary.prr.test.R  | perform permutations for cox analysis  |
| prr.test.R  | permutations for cox analysis  |
| glm.perm.R  | permutations for cox analysis  |
| Cox.R  | permutations for cox analysis  |
| CEL_to_mixture.R  | array data processing  |
| Model.R  | build prognositic models  |

# Shiny
In this folder, the scripts used to generate the online webtool for CGRS were provided.
