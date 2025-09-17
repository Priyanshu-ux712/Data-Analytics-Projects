import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

data = pd.read_csv("C:/Users/priyanshu/OneDrive/Documents/Analytics_project_3/Sample_Superstore.csv", encoding='latin1')
print(data.info())
# print(data.isnull().sum())

data['Order Date'] = pd.to_datetime(data['Order Date'].str.replace("-", "/", regex=False), errors='coerce')


data['Ship Date'] = pd.to_datetime(data['Ship Date'].str.replace("-", "/", regex=False), errors='coerce')


print(data.head(20))
print(data.info())

# data.to_csv("modified_Sample_Superstore.csv",index= False)

