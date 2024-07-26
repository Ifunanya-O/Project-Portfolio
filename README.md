Welcome to my machine learning project portfolio! This repository showcases various machine learning projects that demonstrate my expertise in predictive modeling, optimization, and forecasting. Below is an overview of the key projects included:

1. Crime Prediction

Model: Linear Regression
Description: Developed a model to predict crime rates based on historical data and various influencing factors.
Applied linear regression techniques to analyze trends and make data-driven predictions.

Dataset used in the project:

Nova Scotia Crime Statistics:
https://data.novascotia.ca/Crime-and-Justice/Crime-Statistics-Incidents-and-rates-for-selected-/m862-kmjy/data_preview

Year 2016 Census:
https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/prof/details/page.cfm?Lang=E&Geo1=CSD&Code1=1209034&Geo2=PR&Code2=12&SearchText=Halifax&SearchType=Begins&SearchPR=01&B1=All&GeoLevel=PR&GeoCode=1209034&TABID=1&type=0

Year 2021 Census:
https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/page.cfm?Lang=E&SearchText=Halifax&DGUIDlist=2021A00051209034&GENDERlist=1,2,3&STATISTIClist=1,4&HEADERlist=0

Result:

Linear regression was run to find point estimates for predicting incident_rate. 

Because of multiple missing values, the model was first run on a subset of data (where Year=2021) which had fewer missing values that were missing at random asides from the Refugees column which had multiple values that were missing not at random. MICE imputations was hence used to replace the values. 

However, the particular column that had most of the missing values was dropped as it didn't belong to the model, therefore, Linear regression model was run without using the MICE imputations. This final model returned the following point estimates:

Crime_Rate = -372.23 + 0.0003Average_total_income + 44.49Low_income_rate + 3.56Non_immigrants + 3.48Non_citizen.

For the total dataset, the Refugees column was dropped too as it had multiple values that were missing not at random. The Low_income_rate column also had a higher amount of missing values, however, the missing values were replaced using MICE imputations. The model was run and these were observed:

The Low_income_rate p-value: 0.64, is higher than alpha:0.05. However, this independent variable was left in the final model because this maybe due to MICE imputations as it had large volume of missing values in the total dataset. Unlike in the 2021 dataset where there was no missing value in the Low_income_rate column, and this subset dataset showed a near zero p-value for Low_income_rate.

The p-value of Postsecondary_Graduate tend to increase when Non_citizen and Non_immigrants variable are removed, suggesting a multicollinearity problem. However, hypothesis testing could not be done on MICE result.

Population has a zero (0) coefficient in the final model which is the same in the subset model. Although in the subset model,population had a higher p-value than alpha(0.05), hence was no included in the final model.

The final model returned the following point estimates:

Crime_Rate = 10.8035 + 0Population + 1.1Low_income_rate + 0.2Visible_Minority + (-0.09)*Owner + (-0.1)*Renter


2. Home Equity Loan Optimization
Models: K-Nearest Neighbors (KNN), Logistic Regression, Decision Tree
Description: Worked on optimizing home equity loan approval processes. Utilized KNN, Logistic Regression, and Decision Tree algorithms to predict loan defaults and identify key factors influencing loan approvals.
4. Food Demand Forecasting
Models: XGBoost, LightGBM
Description: Created forecasting models to predict food demand for various locations. Leveraged XGBoost and LightGBM algorithms to handle large datasets and improve forecasting accuracy.
Additional Work
Exploratory Data Analysis (EDA): Performed comprehensive exploratory data analysis to understand the datasets, uncover patterns, and prepare data for modeling.
Feature Engineering: Conducted feature engineering to enhance model performance by creating new features and selecting the most relevant ones.
Explore the individual project directories for detailed information, code, and results. Each project demonstrates my ability to apply machine learning techniques to real-world problems and drive valuable insights.



