setwd('C:/Users/sdasgup2/Desktop/Work/TestDirectory')

library(dplyr)
library(MASS)
library(e1071)
library(xlsx)
library(ROCR)
library(pROC)

## 0. FOR REPRODUCIBLE RESULTS

set.seed(1000)

## 1. READ DATA FILE
## 2. BUILD TRAINING/TEST/VALIDATION DATA

data <- read.xlsx("iHRD-datafreeze-July2020-NatCom_final.xlsx", sheetIndex = 1, colIndex = 2:12)
data$HRD_input_category <- as.factor(data$HRD_input_category)
train.data <- droplevels(data[data$HRD_input_category%in%c(0, 1), ])

## FEATURES: LOH, Ploidy, Sig 3, Sig 8, Mut_burden, Number_of_segments
## OUTCOME: HRD_input_category/Validation_category

train.data.x <- train.data[, c('LOH', 'Mut_burden', 'Sig3', 'Sig8', 'Number_of_segments', 'Ploidy')]
train.data.y <- train.data$HRD_input_category

######################################################################################################################################################

## 3. DRY RUN WITH FULL DATA

## 3i. TUNING SPACE

costvec = 10^(-3:1)
gammavec = c(0.00001, 0.0001, 0.001, 0.01, 0.1, 0.15, 0.2, 0.5, 1, 2, 3, 4, 5)

## 3ii. CV TUNING 

tune.obj.nl <- tune.svm(HRD_input_category ~ LOH + Mut_burden + Sig3 + Sig8 + Number_of_segments + Ploidy, data = train.data,				
                        kernel = 'radial', cost = costvec, gamma = gammavec, tunecontrol = tune.control(nrepeat = 20, cross = 10))
tune.obj.nl

## 3iii. RUN MODEL

svm.fit.nl <- svm(HRD_input_category ~ LOH + Mut_burden + Sig3 + Sig8 + Number_of_segments + Ploidy, data = train.data, 
                  cost = tune.obj.nl$best.parameters$cost, gamma = tune.obj.nl$best.parameters$gamma, kernel='radial', probability = T)

## 3iv. TRAINING ERROR

pred.train <- predict(svm.fit.nl, train.data.x, decision.values =  T)
pred.train
train.error <- mean(pred.train != train.data.y)


## 3v. TEST PREDICTION on test data 

## test data
test.data <- data[data$HRD_input_category%in%c(2), ]
test.data.x <- test.data[, c('LOH', 'Mut_burden', 'Sig3', 'Sig8', 'Number_of_segments', 'Ploidy')]

pred.test <- predict(svm.fit.nl, test.data.x, decision.values =  T)
pred.test


## 3vi. TEST PREDICTION on model test data (input your own data here)

## model test data (input your own test data here)
## order important  with variable names - LOH, Mut_burden, Sig3, Sig8, Number_of_segments, Ploidy 

# model.test.data <- read.csv('model_test_data.csv', header = T)
# model.test.data.x <- model.test.data[, c('LOH', 'Mut_burden', 'Sig3', 'Sig8', 'Number_of_segments', 'Ploidy')]
# pred.model.test <- predict(svm.fit.nl, model.test.data.x, decision.values =  T)
# pred.model.test
