import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

values = np.array([1, 3, 2, 4, 1, 6, 4])
example_df = pd.DataFrame({
    'value': values,
    'even': values % 2 == 0,
    'above_three': values > 3
}, index=['a', 'b', 'c', 'd', 'e', 'f', 'g'])

# Change False to True for this block of code to see what it does

# groupby() without as_index
if False:
    first_even = example_df.groupby('even').first()
    print first_even
    print first_even['even'] # Causes an error. 'even' is no longer a column in the DataFrame

# groupby() with as_index=False
if False:
    first_even = example_df.groupby('even', as_index=False).first()
    print first_even
    print first_even['even'] # Now 'even' is still a column in the DataFrame

filename = '/datasets/ud170/subway/nyc_subway_weather.csv'
subway_df = pd.read_csv(filename)

#Make a scatterplot of subway stations with latitude and longitude as the x
# and y axes and ridership as the bubble size

#group data by latitude and longitude first & find mean riderhip per location
#as index = false keeps lat & long as columns of df
data_by_location = subway_df.groupby(['latitude', 'longitude'], as_index=False).mean()

#get out latitudes and longitudes in order to make plot
data_by_location.head()['latitude']

scaled_entries = (data_by_location[ENTRIESn_hourly] /
                  data_by_location[ENTRIESn_hourly].std())

plt.scatter(data_by_location['latitude'], data_by_location['longitude'],
            s=scaled_entries)
