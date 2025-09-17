import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine

data = pd.read_csv("C:/Users/priyanshu/OneDrive/Documents/Analytics_Project_5/renewable_capacity_timeseries.csv")
# print(data.info())
# print(data.isnull().sum())
# numeric_column = []
# for col in data.columns:
#     if pd.to_numeric(data[col],errors="coerce").notna().all():
#         numeric_column.append(col)
#
# print(len(numeric_column))
# print(data.info())

data.rename(columns={"DE_wind_offshore_capacity" : "DE_wind-offshore_capacity","DE_wind_onshore_capacity" :"DE_wind-onshore_capacity",
                "DK_wind_offshore_capacity" :"DK_wind-offshore_capacity","CH_wind_onshore_capacity" :"CH_wind-onshore_capacity",
    "GB-GBN_wind_offshore_capacity" :"GB-GBN_wind-offshore_capacity","GB-GBN_wind_onshore_capacity" :"GB-GBN_wind-onshore_capacity",
              "DK_wind_onshore_capacity" :"DK_wind-onshore_capacity","FR_wind_onshore_capacity" :"FR_wind-onshore_capacity",
              "SE_wind_offshore_capacity" :"SE_wind-offshore_capacity","SE_wind_onshore_capacity" :"SE_wind-onshore_capacity",
    "GB-NIR_wind_onshore_capacity" :"GB-NIR_wind-onshore_capacity","GB-UKM_wind_offshore_capacity" :"GB-UKM_wind-offshore_capacity",
          "GB-UKM_wind_onshore_capacity" :"GB-UKM_wind-onshore_capacity",},
            inplace=True)
# print(data.info())

converted_data = pd.melt(data,id_vars="day",var_name="Country_Energy",value_name="Energy_Power")
# print(converted_data)
converted_data[["Country","Energy_Source","Capacity"]] = (converted_data["Country_Energy"].str.split("_",expand=True))
converted_data = converted_data.drop(columns=["Country_Energy","Capacity"])
converted_data = converted_data[["day","Country","Energy_Source","Energy_Power"]]
print(converted_data)

# engine = create_engine("mysql+pymysql://root:priyanshu69@localhost:3306/renewable_energy")
# converted_data.to_sql(name = "Renewable_Energy",con=engine,if_exists="replace",index=False,chunksize = 100000)


# converted_data.to_csv("C:/Users/priyanshu/OneDrive/Documents/Analytics_Project_5/converted_renewable_capacity_timeseries.csv",
# index=False)