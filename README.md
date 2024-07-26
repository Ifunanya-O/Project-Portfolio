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

The crime prediction model used linear regression to estimate the incident_rate. 
Initially, the model was applied to a subset of data (Year=2021) with fewer missing values. 

For missing values in the Refugees column, which were not missing at random, MICE imputations were used, but this column was later dropped due to its irrelevance. The final model provided the following estimates:

Crime_Rate = -372.23 + 0.0003Average_total_income + 44.49Low_income_rate + 3.56Non_immigrants + 3.48Non_citizen

For the full dataset, the Refugees column was excluded, and MICE imputations were used for the Low_income_rate column. 

The final model estimates were:

Crime_Rate = 10.8035 + 0Population + 1.1Low_income_rate + 0.2Visible_Minority - 0.09Owner - 0.1*Renter

Notably, issues with multicollinearity were observed, and some variables (Population) had coefficients of zero or high p-values, influencing their inclusion in the final model.


2. Home Equity Loan Optimization
Models: K-Nearest Neighbors (KNN), Logistic Regression, Decision Tree
Description: Worked on optimizing home equity loan approval processes. Utilized KNN, Logistic Regression, and Decision Tree algorithms to predict loan defaults and identify key factors influencing loan approvals.

Dataset used in the project: 
http://www.creditriskanalytics.net/datasets-private2.html

Result:

A comprehensive analysis of the likelihood of default on home equity loans using Logistic Regression, KNN, and Classification Tree models has provided significant insights into the key predictors of loan defaults. The findings indicate that traditional metrics like the LTV ratio may not be as critical in predicting defaults as previously thought. Instead, factors such as DEBTINC_AVAIL (NOA Income availability), DEROG (Number of Major Derogatory Reports), and DELINQ (Delinquency on the Line of Credit) have emerged as crucial indicators.

The performance of the three models, particularly the Classification Tree and Logistic Regression models, has highlighted the importance of these variables. The KNN model, while effective, showed a slightly lower performance compared to the other models. The refined Logistic Regression model, with optimized thresholds, demonstrated an improved balance between precision and recall, ensuring a more reliable identification of defaults.



3. Food Demand Forecasting
Models: XGBoost, LightGBM
Description:

Created forecasting models to predict food demand for various locations. Leveraged XGBoost and LightGBM algorithms to handle large datasets and improve forecasting accuracy.

Data Preprocessing, Exploratory Data Analysis and Feature Engineering

Exploratory Data Analysis (EDA): Performed comprehensive exploratory data analysis to understand the datasets, uncover patterns, and prepare data for modeling.

Feature Engineering: Conducted feature engineering to enhance model performance by creating new features and selecting the most relevant ones.

Explore the individual project directories for detailed information, code, and results. Each project demonstrates my ability to apply machine learning techniques to real-world problems and drive valuable insights.



