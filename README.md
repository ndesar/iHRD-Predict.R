# iHRD-Predict.R
Classify tumors based on Homologous Recombination Pathway Deficiency status of tumors

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

user.test.data <- read.csv('model_test_data.csv', header = T)
pred.user.test <- predict(svm.fit.nl, user.test.data, decision.values =  T)
pred.user.test<-data.frame(cbind(Sample_id=user.test.data$Sample_id, pred.user.test))

Write.table(Pred.user.text, file="iHRD_pred_annotation_user.txt", sep="\t")


## Running iHRD on non mCRPC cancer types
use ordered table. Define large train data to estimate optimal gamma and cost. Execute iHRD_Predict.R 

Test file need to have HRD_input_category label set at 2
Example input table: 

	Input Ref Sample_id	HRD_input_category	LOH	Ploidy	Mutation Count	Number_of_segments	Sig3	Sig8	Mut_burden
239	41	2	0.112	1.9	151	117	0	0.07	1.709692029
240	42	2	0.127	2.6	106	62	0.12	0	1.268245992
241	43	2	0.02	2.1	585	252	0.29	0	6.623641304
242	45	2	0.123	4	423	118	0.31	0	11.51647155
243	47	2	0.231	2.2	272	245	0.18	0	3.079710145
244	53	2	0.15	5.1	652	705	0.28	0.07	7.382246377
245	70	2	0.18	3.5	369	205	0.28	0	4.17798913
246	71	2	0.173	2.6	364	525	0.26	0	4.121376812
247	72	2	0.076	3.5	348	329	0.18	0	3.940217391
248	74	2	0.07	4.4	331	564	0.21	0	3.747735507
249	78	2	0.196	2.3	246	1146	0.17	0	2.785326087
250	01-095C6_LIVER.pdf	2	0.129	3.6	823	174	0.26	0	12.10294118
251	01-095N1_LN.pdf	2	0.127	3.8	868	186	0.32	0	12.76470588
252	03-163S4_LIVER.pdf	2	0.137	3.1	221	121	0.17	0	3.25
253	04-149E2_LN.pdf	2	0.172	4.5	603	134	0.48	0	8.867647059
254	04-149J1_CAP.pdf	2	0.173	4.5	432	134	0.35	0	6.352941176
255	05-011D2_LN.pdf	2	0.157	4.4	504	142	0.48	0	7.411764706
256	05-011G4_LUNG.pdf	2	0.194	2.2	448	124	0.38	0	6.588235294
257	11-028G3_ADRENAL.pdf	2	0.108	1.9	410	84	0.29	0	6.029411765
258	11-028L1_LUNG.pdf	2	0.109	2	550	115	0.17	0	8.088235294
259	97-159H2_LIVER.pdf	2	0.216	3.3	139	188	0.23	0	2.044117647![image](https://user-images.githubusercontent.com/33163983/116130236-d7696c80-a67f-11eb-8213-1a5708269702.png)



