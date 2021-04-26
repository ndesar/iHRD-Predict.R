# iHRD-Predict.R
Classify tumors based on Homologous Recombination Pathway Deficiency status of tumors (Authors: Navonil De Sarkar & Sayan Dasgupta. Collaborator/Contributor: Brian Hanratty)

iHRD is a binary classification framework for determining tumors' Homologous Recombination pathway's (HR) functional status. The current version freeze of iHRD is trained and tested for metastatic prostate tumor classification using standard paired whole-exome sequencing derived genomic features. 

## Description
iHRD is a simplistic implementation of the SVM Radial Basis Function to do a binary classification.

## Uses

iHRD classification inference can help determine the HR functional activity (independent of its detected HR pathway gene mutation or copy number aberration status). This tool utilizes functional HR deficiency associated with multiple genomic scar scores for accurate classification of a tumor. This classification method may potentially contribute to therapy choice determination in mCRPC.




# Implementing iHRD_predict.R 

INTRODUCTION:iHRD is a R package which determines the tumor label 0 for HR intact phenotype and 1 for homologous recombination deficiency based on Tumor Normal paired NGS (WES) data.
Multifeature approach of detecting homologous recombination deficiency is an effective approach now. It is became more relavant, as we know HR Deficient tumors are particularly more sensitive to certain therapies (PARPi/PLAT). A prior tool HRDdetect adopts a regression model and performs a multiparametric prediction of HRD in tumors. The tool was primarily built for Breast and Overian Cancers and it's implementation requirs WGS data. Since the next generation whole exome sequencing is relatively cost effective approach and substantially less storage demanding, it has become important to develop algorithms that derive the same type of genomic scar-score based multiparametric HRD determination from exome/clinical exome dataset. In order to perform this analysis, here we introduce the iHRD. It is a R implement classification framework, integrating multiparametric feture scores that are reliably derivable from exomes to perform efficient classification on HRD phenotype. iHRD is a non linear SVM-RBF classification framework.

#SVM classification implementation to perform binary HRD prediction from 6 input features.

## REQUIREMENTS:
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

See iHRDPredict.html


# Train data iHRD label & Discision values
pred.train

##test data in workspace assign iHRD designation to mCRPC tumor samples and LuCaP PDX samples in "iHRD-datafreeze-July2020-NatCom_final.xlsx" (COl2#label2)
#test.data <- data[data$HRD_input_category%in%c(2)]
#test.data.x <- test.data[, c(3,9, 7, 8, 6, 4)]

#pred.test <- predict(svm.fit.nl, test.data.x, decision.values =  T)

pred.test
Pred=data.frame(cbind(Sample_id=test.data$Sample_id_su2c, pred.test))
Write.table(Pred, file="iHRD_pred_annotation.txt", sep="\t")


## TEST PREDICTION on model test data (input your own data here)
model test data (input your own test data here)
Order of columns important with variable names - LOH, Mut_burden, Sig3, Sig8, Number_of_segments, Ploidy, Sample_id (refer example)

Input file examples(Minimal):
a<-read.table("/examples/test1.small.seqz.gz", header=T)
[sample_input _data_iHRD.txt](https://github.com/ndesar/iHRD_predict/files/6288197/sample_input._data_iHRD.txt)
Input file examples(Expanded):

user.test.data <- read.csv('model_test_data.csv', header = T)
pred.user.test <- predict(svm.fit.nl, user.test.data, decision.values =  T)
pred.user.test<-data.frame(cbind(Sample_id=user.test.data$Sample_id, pred.user.test))

Write.table(Pred.user.text, file="iHRD_pred_annotation_user.txt", sep="\t")

Example input file format


![image](https://user-images.githubusercontent.com/33163983/116132499-7becae00-a682-11eb-9398-2baef81571bf.png)

