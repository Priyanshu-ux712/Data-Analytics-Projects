import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

data = pd.read_csv("C:/Users/priyanshu/OneDrive/Documents/Data_Analytics_Projects/Chocolate_Sales.csv")
# print(data)
# print(data.isnull().sum())
# print(data.columns)
# group = data.groupby(["Country"]).agg({"Amount": ["sum"],
#                                        "Boxes Shipped":["sum"]}).reset_index()
# print(group)
# group.to_csv("Sales and boxes per month.csv",index=False)

########################################################################################################################################

# sales = data.groupby(["Sales Person"]).agg({"Amount":["sum"]}).reset_index()
# sales.rename(columns={"Amount":"Total_Revenue"},inplace=True) # inplace is for to change in the grouped dataset.
# total_money = sales["Total_Revenue"].sum()
# sales["Contribution_%"] = (sales["Total_Revenue"]/total_money*100).round(2)
# print(sales)
# sales.to_csv("Revenue and contribution.csv",index=False)

########################################################################################################################################

# product = data.groupby(["Product"]).agg(Total_Revenue = ("Amount","sum"),
#                                         Total_Boxes_Shipped = ("Boxes Shipped","sum")).reset_index()
# product = product.sort_values(by="Total_Boxes_Shipped",ascending=False)
# Most_Sell = product.iloc[0] # this is for to get the first row not on the basis of row index but on the basis of table's index. different
# # from loc[].
# print(product)
# product.to_csv("Sales by Product.csv",index=False)

########################################################################################################################################

# data["Amount"] = data["Amount"].str.replace(",","").astype(float)
# correlation = data["Boxes Shipped"].corr(data["Amount"])
# print(f"{correlation:.2f}")

########################################################################################################################################

