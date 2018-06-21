# Firm Vitality Predictive Model

## Introduction

This sample project builds a machine learning model to predict which employers survive in the following years based on firm characteristics, industrial sector, and geography. Potential applications include intervention on failing firms and identification of weakening industries.

The model's labels and features are created in the "Data Preparation" notebook. The other notebook runs the actual model and compares the results to relevant baselines.

## Datasets Used

The label (outcome variable) of our Machine Learning model is whether an employer in question still exists one year after the prediction year. This binary variable is generated using the Missouri State QCEW Employers dataset.

The model's features can come any of the following datasets:
- Missouri State QCEW Employers data (number of employees, total payroll, industry, geography)
- Missouri State Wage data (employee wages)
- Kansas City, MO, Business License data (activity, address)
- LEHD LODES data (block-level demographic features)
- Kansas City, MO, Water Services data (water consumption)
