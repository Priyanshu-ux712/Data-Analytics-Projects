import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# data = pd.read_csv("C:/Users/priyanshu/OneDrive/Documents/Analytics_Project_2/electric_vehicles_spec_2025.csv")
# # print(data)
# # print(data.columns)
#
# print(data.info())
#
# numeric_column = []
# for col in data.columns:
#     try:
#         sample = pd.to_numeric(data[col].dropna().head(10), errors="coerce")
#         if sample.notna().sum() >= len(sample)//2 :
#             numeric_column.append(col)
#     except():
#
#         continue
# # print(numeric_column)
# data[numeric_column] = data[numeric_column].apply(pd.to_numeric,errors = "coerce")
#
# print(data.isnull().sum())
# numeric_blank_columns = data.select_dtypes(include="number").columns
# data[numeric_blank_columns] = data[numeric_blank_columns].fillna(data[numeric_blank_columns].mean())
# print(data.isnull().sum())
#
# string_blank_columns = data.select_dtypes(include="object").columns
# for col in string_blank_columns :
#     data[col] = data[col].fillna(data[col].mode()[0])
# print(data.isnull().sum())
#
#
# # # data.to_csv("Modified electric_vehicles_spec_2025.csv")
# # #####################################################################################################################################
# # print(data.info())
#
# xx = data[['top_speed_kmh', 'torque_nm', 'efficiency_wh_per_km', 'range_km', 'acceleration_0_100_s']].corr()
# print(xx)
# xx.to_csv("5Correlation.csv",index=True)


# corr_matrix = data[['top_speed_kmh', 'torque_nm', 'efficiency_wh_per_km', 'range_km', 'acceleration_0_100_s']].corr()
# plt.figure(figsize=(6,6))
# sns.heatmap(corr_matrix, annot=True, cmap='coolwarm')
# plt.title("Correlation Matrix")
# plt.show()
