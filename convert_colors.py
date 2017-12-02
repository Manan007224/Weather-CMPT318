import numpy as np
import pandas as pd
from math import *


filename = 'image_data/KATKAM_colors.csv'
data = pd.read_csv(filename,header=None)
data.columns=['file_index','region','r','g','b']
data['r'] = (data['r']*255)
data['g'] = (data['g']*255)
data['b'] = (data['b']*255)

func = lambda x : floor(x)

data['r'] = data['r'].apply(func)
data['g'] = data['g'].apply(func)
data['b'] = data['b'].apply(func)

print(data.head())
