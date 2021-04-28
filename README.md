# iHRD-Predict.R
Classify tumors based on Homologous Recombination Pathway Deficiency status of tumors 
## ###################################################################################
(_Authors: Navonil De Sarkar & Sayan Dasgupta. Collaborator/Contributor: Brian Hanratty_)

## License 
ndesar/iHRD-Predict.R is licensed under the
GNU General Public License v3.0
(refer LICENSE.md)

iHRD is a binary classification framework for determining tumors' Homologous Recombination pathway's (HR) functional status. The current version freeze of iHRD is trained and tested for metastatic prostate tumor classification using paired whole-exome sequence data derived genomic features. 

## Description
iHRD is an implementation of the support vector machine (SVM) Radial Basis Function(RBF) to do a binary classification.

## Uses

iHRD classification help determining the HR functional activity status, independent of its detected HR pathway gene mutation or copy number aberration status in mCRPC tumors. The tool utilizes HR deficiency-associated genomic scar scores for accurate classification of a tumor. This classification method may potentially contribute to therapy choice determination in mCRPC.

## SYSTEM REQUIREMENTS:
R installed (tested with v.3.6 and 4.0)
Tested on Linux, Windows, Mac (R Studio/Terminal)

# DEPENDENCIES
library(dplyr)
library(MASS)
library(e1071)
library(xlsx)
library(ROCR)
library(pROC)

NOTE: Analysis required paired tumor-normal exome sequence data.
NOTE: Normalization required based on Exome definition.

# CITATION:
Under Revision;

## Running iHRD on mCRPC: 

## Input Features: 
1. COSMIC Sig3 and 2.COSMIC Sig8 weights from DeconstructSigs.
3. Mutation Burden (MuTect1 PASS filter and minimum depth of coverage 14 filter, alt allele support 6X filter).
4. Number of Segments (Derived from Sequenza pipeline)
5. Ploidy (Ploidy estimates using Sequenza)
6. LOH score estimation was performed using LOH_Salipante (will be shared on request).

(mCRPC model freeze V1)

# Example

See iHRDPredict.pdf iHRDPredict.html 

Example input file format (10 column *.Xlsx compatible)


![image](https://user-images.githubusercontent.com/33163983/116132499-7becae00-a682-11eb-9398-2baef81571bf.png)

