import os
import numpy as np
import pandas as pd

WEATHER_DIR = './weather'


all_files = os.listdir(WEATHER_DIR)
data = pd.DataFrame()

for weather_file in all_files :

    if str(weather_file[-4:]) == '.csv' :

        file_path = os.path.join(WEATHER_DIR,str(weather_file))
        wdata = pd.read_csv(str(file_path),skiprows=range(16))
        
        data = data.append(wdata)

print(data.shape)
