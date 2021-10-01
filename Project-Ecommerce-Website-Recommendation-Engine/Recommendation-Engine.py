#import files
import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt
from scipy import stats
import math

#Read in data file
data = pd.read_excel("finalData.xlsx",sheet_name=0)

#focus dataset on rfm columns
columns = ['id', 'Recency(Days)', "Frequency(Days)", "Monetary($)","Time on File (Days)"]
rfmTable = pd.DataFrame(data, columns=columns)
# Rename columns for ease of use
rfmTable.rename(columns={'Recency(Days)': 'Recency', "Frequency(Days)": 'Frequency',"Monetary($)": 'Monetary'}, inplace=True)
#remove rows with frequency 0 to eliminate division by 0 issues
rfmTable = rfmTable[rfmTable.Frequency != 0]
#sort by monetary value and remove four outliers
sortedMonetary = rfmTable.sort_values(by=['Monetary'], ascending=False)
sortedMonetary = sortedMonetary.iloc[4:]
rmOutliers = sortedMonetary.copy()

#Calculate rfm score
rmOutliers["rfmScore"]= ((np.log(rmOutliers.Frequency))*rmOutliers.Monetary)/rmOutliers.Recency
sortedRfmTable = rmOutliers.sort_values(by=['rfmScore'], ascending=False)
#get total rows
count_row = sortedRfmTable.shape[0]
#get 15%
fifteenPercent=count_row*0.15
fifteenPercent=int(fifteenPercent)
dataPartition=sortedRfmTable[:fifteenPercent]


#split the metrics into segments using quantiles.

quantiles = dataPartition.quantile(q=[0.25,0.50,0.75])
quantiles = quantiles.to_dict()
segmented_rfm = dataPartition.copy()

#We assign a score from 1 to 4 to Recency, Frequency and Monetary. 
#1= best/highest value, and 4= lowest/worst value. 
def tofScore(x,p,d):
    if x <= d[p][0.25]:
        return 1
    elif x <= d[p][0.50]:
        return 2
    elif x <= d[p][0.75]: 
        return 3
    else:
        return 4
def RScore(x,p,d):
    if x <= d[p][0.25]:
        return 1
    elif x <= d[p][0.50]:
        return 2
    elif x <= d[p][0.75]: 
        return 3
    else:
        return 4
    
def FMScore(x,p,d):
    if x <= d[p][0.25]:
        return 4
    elif x <= d[p][0.50]:
        return 3
    elif x <= d[p][0.75]: 
        return 2
    else:
        return 1
# add scores to dataset
segmented_rfm['R_quartile'] = segmented_rfm['Recency'].apply(RScore, args=('Recency',quantiles))
segmented_rfm['F_quartile'] = segmented_rfm["Frequency"].apply(FMScore, args=("Frequency",quantiles))
segmented_rfm['M_quartile'] = segmented_rfm["Monetary"].apply(FMScore, args=("Monetary",quantiles))
segmented_rfm['Tof_quartile'] = segmented_rfm["Time on File (Days)"].apply(tofScore, args=("Time on File (Days)",quantiles))
segmented_rfm['RFM_Segment'] = segmented_rfm.R_quartile.map(str)+segmented_rfm.F_quartile.map(str)+segmented_rfm.M_quartile.map(str)

print(segmented_rfm.head())
#Assign segments to scores
best=[]
loyal=[]
bigspender=[]
new=[]

#add ids to respective list
segments = [tuple(r) for r in segmented_rfm[['id', 'RFM_Segment']].to_numpy()]
segments2 = [tuple(r) for r in segmented_rfm[['id', 'Tof_quartile']].to_numpy()]
for i in segments:
	if i[1] == '111':
		best.append(i[0])
	elif i[1][1] == '1':
		loyal.append(i[0])
	elif i[1][2] == '1':
		bigspender.append(i[0])
	else:
		new.append(i[0])


#add in the new customers
for i in segments2:
	if i[1]==1 and i[0] not in best and i[0] not in loyal and i[0] not in bigspender and i[0] not in new:
		new.append(i[0])
#print list lengths
print("Best Customers: ",len(best))
print("Loyal Customers: ",len(loyal))
print("Big spenders: ",len(bigspender))
print("New Customers: ",len(new))

#print calculations
filteredBest = segmented_rfm.loc[segmented_rfm['id'].isin(best)]
print("Best Recency Avg: ",filteredBest["Recency"].mean())
print("Best Frequency Avg: ",filteredBest["Frequency"].mean())
print("Best Monetary Avg: ",filteredBest["Monetary"].mean())
print("Best Tof Avg: ",filteredBest["Time on File (Days)"].mean())

filteredLoyal = segmented_rfm.loc[segmented_rfm['id'].isin(loyal)]
print("Loyal Recency Avg: ",filteredLoyal["Recency"].mean())
print("Loyal Frequency Avg: ",filteredLoyal["Frequency"].mean())
print("Loyal Monetary Avg: ",filteredLoyal["Monetary"].mean())
print("Loyal Tof Avg: ",filteredLoyal["Time on File (Days)"].mean())

filteredbigspender = segmented_rfm.loc[segmented_rfm['id'].isin(bigspender)]
print("Spender Recency Avg: ",filteredbigspender["Recency"].mean())
print("Spender Frequency Avg: ",filteredbigspender["Frequency"].mean())
print("Spender Monetary Avg: ",filteredbigspender["Monetary"].mean())
print("Spender Tof Avg: ",filteredbigspender["Time on File (Days)"].mean())

filterednew = segmented_rfm.loc[segmented_rfm['id'].isin(new)]
print("New Recency Avg: ",filterednew["Recency"].mean())
print("New Frequency Avg: ",filterednew["Frequency"].mean())
print("New Monetary Avg: ",filterednew["Monetary"].mean())
print("New Tof Avg: ",filterednew["Time on File (Days)"].mean())
print(segmented_rfm.head(20))
