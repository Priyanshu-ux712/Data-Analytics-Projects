from statistics import correlation
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine

d1 = pd.read_excel(Database Path)

# print(d1.columns)
# print(d1.info())
# print(d1.isnull().sum())
# for column in d1:
#     if d1[column].isnull().any():
#         d1[column] = d1[column].fillna(d1[column].mean())
# print(d1.isnull().sum())
#
# d2 = pd.DataFrame(d1.describe())
# print(d2.columns)
# d1.to_csv(Database Path, index=False)
# d2.to_csv(Database Path)

# engine = create_engine("mysql+pymysql://root:password@localhost:XXXX/Database_name")
# d1.to_sql(name = "Table_name",con=engine,if_exists="replace",index=False,chunksize = 100000)

# Index(['day', 'relative_humidity_2m (%)', 'rain (mm)', 'surface_pressure (hPa)', 'wind_speed_10m (km/h)',
# 'wind_direction_10m (Â°)', 'wind_speed_100m (km/h)', 'wind_direction_100m (Â°)', 'PM10 (Âµg/mÂ³)', 'NO (Âµg/mÂ³)',
# 'NO2 (Âµg/mÂ³)', 'NOx (ppb)', 'NH3 (Âµg/mÂ³)', 'SO2 (Âµg/mÂ³)', 'CO (mg/mÂ³)', 'Ozone (Âµg/mÂ³)', 'Benzene (Âµg/mÂ³)',
# 'Toluene (Âµg/mÂ³)', 'Xylene (Âµg/mÂ³)', 'Eth-Benzene (Âµg/mÂ³)', 'MP-Xylene (Âµg/mÂ³)'],

d3 = pd.read_csv(Database Path)


# | 0.00 – 0.19 | Very weak / none |
# | 0.20 – 0.39 | Weak |
# | 0.40 – 0.59 | Moderate |
# | 0.60 – 0.79 | Strong |
# | 0.80 – 1.00 | Very strong |


def check(a):
    x = abs(a)
    match x:
        case _ if 0 <= x <= 0.19:
            s = "very weak correlation"
        case _ if 0.20 <= x <= 0.39:
            s = "weak correlation1"
        case _ if 0.40 <= x <= 0.59:
            s = "moderate correlation2"
        case _ if 0.60 <= x <= 0.79:
            s = "strong correlation3"
        case _ if 0.80 <= x <= 1.00:
            s = "very strong correlation4"

    direction = "Positive" if a > 0 else "Negative" if a < 0 else "NO Correlation"
    print(f"{a} shows {direction} and {s}")


# a1 = correlation(d3["PM10 (Âµg/mÂ³)"],d3["wind_speed_10m (km/h)"])
# check(a1)
# a2 = correlation(d3["PM10 (Âµg/mÂ³)"],d3["wind_speed_100m (km/h)"])
# check(a2)
# a3 = correlation(d3["PM10 (Âµg/mÂ³)"],d3["rain (mm)"])
# check(a3)
# a4 = correlation(d3["PM10 (Âµg/mÂ³)"],d3["relative_humidity_2m (%)"])
# check(a4)
# a5 = correlation(d3["NO (Âµg/mÂ³)"],d3["wind_speed_10m (km/h)"])
# check(a5)
# a6 = correlation(d3["NO2 (Âµg/mÂ³)"],d3["wind_speed_10m (km/h)"])
# check(a6)
# a7 = correlation(d3["NOx (ppb)"],d3["wind_speed_10m (km/h)"])
# check(a7)
# a8 = correlation(d3["NO (Âµg/mÂ³)"],d3["NO2 (Âµg/mÂ³)"])
# check(a8)
# a9 = correlation(d3["NO (Âµg/mÂ³)"],d3["NOx (ppb)"])
# check(a9)
# b1 = correlation(d3["NO2 (Âµg/mÂ³)"],d3["NOx (ppb)"])
# check(b1)
# b2 = correlation(d3["NO2 (Âµg/mÂ³)"],d3["NO (Âµg/mÂ³)"])
# check(b2)
# b3 = correlation(d3["NOx (ppb)"],d3["NO (Âµg/mÂ³)"])
# check(b3)
# b4 = correlation(d3["NOx (ppb)"],d3["NO2 (Âµg/mÂ³)"])
# check(b4)
# b5 = correlation(d3["NOx (ppb)"],d3["Ozone (Âµg/mÂ³)"])
# check(b5)
# b6 = correlation(d3["CO (mg/mÂ³)"],d3["NO2 (Âµg/mÂ³)"])
# check(b6)
# b7 = correlation(d3["CO (mg/mÂ³)"],d3["NOx (ppb)"])
# check(b7)
# b8 = correlation(d3["PM10 (Âµg/mÂ³)"],d3["NH3 (Âµg/mÂ³)"])
# check(b8)
# b9 = correlation(d3["SO2 (Âµg/mÂ³)"],d3["wind_speed_10m (km/h)"])
# check(b9)
#
# # 'Benzene (Âµg/mÂ³)','Toluene (Âµg/mÂ³)', 'Xylene (Âµg/mÂ³)', 'Eth-Benzene (Âµg/mÂ³)'
# c1 = correlation(d3["Benzene (Âµg/mÂ³)"],d3["Toluene (Âµg/mÂ³)"])
# check(c1)
# c2 = correlation(d3["Benzene (Âµg/mÂ³)"],d3["Xylene (Âµg/mÂ³)"])
# check(c2)
# c3 = correlation(d3["Benzene (Âµg/mÂ³)"],d3["Eth-Benzene (Âµg/mÂ³)"])
# check(c3)
# c4 = correlation(d3["Toluene (Âµg/mÂ³)"],d3["Benzene (Âµg/mÂ³)"])
# check(c4)
# c5 = correlation(d3["Toluene (Âµg/mÂ³)"],d3["Xylene (Âµg/mÂ³)"])
# check(c5)
# c6 = correlation(d3["Toluene (Âµg/mÂ³)"],d3["Eth-Benzene (Âµg/mÂ³)"])
# check(c6)
# c7 = correlation(d3["Xylene (Âµg/mÂ³)"],d3["Benzene (Âµg/mÂ³)"])
# check(c7)
# c8 = correlation(d3["Xylene (Âµg/mÂ³)"],d3["Toluene (Âµg/mÂ³)"])
# check(c8)
# c9 = correlation(d3["Xylene (Âµg/mÂ³)"],d3["Eth-Benzene (Âµg/mÂ³)"])
# check(c9)
# e1 = correlation(d3["Eth-Benzene (Âµg/mÂ³)"],d3["Benzene (Âµg/mÂ³)"])
# check(e1)
# e2 = correlation(d3["Eth-Benzene (Âµg/mÂ³)"],d3["Toluene (Âµg/mÂ³)"])
# check(e2)
# e3 = correlation(d3["Eth-Benzene (Âµg/mÂ³)"],d3["Xylene (Âµg/mÂ³)"])
# check(e3)
#
# e4 = correlation(d3["NOx (ppb)"],d3["Benzene (Âµg/mÂ³)"])
# check(e4)
# e5 = correlation(d3["NOx (ppb)"],d3["Toluene (Âµg/mÂ³)"])
# check(e5)
# e6 = correlation(d3["NOx (ppb)"],d3["Xylene (Âµg/mÂ³)"])
# check(e6)
# e7 = correlation(d3["NOx (ppb)"],d3["Eth-Benzene (Âµg/mÂ³)"])
# check(e7)

cols = [
'relative_humidity_2m (%)', 'rain (mm)', 'surface_pressure (hPa)', 'wind_speed_10m (km/h)',
'wind_direction_10m (Â°)', 'wind_speed_100m (km/h)', 'wind_direction_100m (Â°)', 'PM10 (Âµg/mÂ³)', 'NO (Âµg/mÂ³)',
'NO2 (Âµg/mÂ³)', 'NOx (ppb)', 'NH3 (Âµg/mÂ³)', 'SO2 (Âµg/mÂ³)', 'CO (mg/mÂ³)', 'Ozone (Âµg/mÂ³)', 'Benzene (Âµg/mÂ³)',
'Toluene (Âµg/mÂ³)', 'Xylene (Âµg/mÂ³)', 'Eth-Benzene (Âµg/mÂ³)', 'MP-Xylene (Âµg/mÂ³)'
]

col = d3[cols]
corr = col.corr(method="pearson")
plt.figure(figsize=(14, 10))
sns.heatmap(
    corr,
    annot=True,
    fmt=".2f",
    cmap="coolwarm",
    linewidths=0.5
)

plt.title("Correlation Heatmap of Air Pollutants and Meteorological Parameters", fontsize=14)
plt.tight_layout()
plt.savefig("First chart.png",pad_inches = 0.9,bbox_inches = "tight")
plt.show()
