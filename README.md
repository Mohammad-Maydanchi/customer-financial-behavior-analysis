Customer Financial Behavior Analysis
This project is based on the Santander Customer Transaction Prediction challenge hosted on Kaggle. The goal is to build a machine learning model to predict which customers are likely to make a specific future transaction based on anonymized financial data.

🧠 Objective
Predict customer behavior using a large-scale dataset of 200,000 anonymized records with 200 numerical features. The classification task involves identifying whether a customer will make a transaction (binary target: 0 or 1).

📊 Methodology
The project follows the CRISP-DM framework:

Business Understanding: Limited context due to anonymized features

Data Understanding: Exploratory analysis of train/test sets with no missing values

Data Preparation: Feature scaling (evaluated but not used), and dataset split into training and validation

Modeling:

Logistic Regression (baseline model)

K-Fold Cross-Validation for robustness

Evaluation: Accuracy, precision, recall, and confusion matrix analysis
