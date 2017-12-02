import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sys
import unittest
import datetime
import os
import re
import warnings
import pdb

warnings.filterwarnings('ignore')

def gather_station_details(sample_filename) :

    station_details = {}

    for line_no,line in enumerate(open(sample_filename,'r')) :
        REGEX = '\"(.*)\"'
        val = re.match(REGEX,line.split(',')[1])

        if line_no ==0 :

            val = val.group(1)[:-1]
            station_details['Station Name'] = val

        if line_no >=1 and line_no <= 7 :

            schema = re.match(REGEX,line.split(',')[0])

            val = val.group(1)
            station_details[schema.group(1)] = val

        elif line_no > 7:
            break

    return station_details

def prepare_weather_data(WEATHER_DIR) :



    all_files = os.listdir(WEATHER_DIR)
    data = pd.DataFrame()

    for weather_file in all_files :

        if str(weather_file[-4:]) == '.csv' :

            file_path = os.path.join(WEATHER_DIR,str(weather_file))
            wdata = pd.read_csv(str(file_path),skiprows=range(16))
            data = data.append(wdata)

    return data

def to_datetime(row) :
    REGEX = '^([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]{2}).*$'
    m = re.match(REGEX,row)

    year = int(m.group(1))
    month = int(m.group(2))
    day = int(m.group(3))
    time =  int(m.group(4))

    return datetime.datetime(year,month,day,time,0,0)


def year_specific(val) :
    ## Function to extract samples with only given years.
    years = ['2016','2017']
    val = str(val)
    if val in years :
        return val
    else :
        return np.nan

def is_rain(val) :
    REGEX1 = '^.*Rain.*$'
    REGEX2 = '^.*Drizzle.*$'
    REGEX3 = '^.*Thunderstorms.*$'
    if re.match(REGEX1,str(val)) is not None or re.match(REGEX2,str(val)) is not None or re.match(REGEX3,str(val)) is not None   :

        return 1
    else :
        return 0

def is_clear(val) :
    if re.match('^.*Clear.*$',str(val) )is not None :
        return 1
    else :
        return 0

def is_snow(val) :
    if re.match('^.*Snow.*$',str(val) )is not None :
        return 1
    else :
        return 0

def is_fog(val) :
    if re.match('^.*Fog.*$',str(val) )is not None :
        return 1
    else :
        return 0

def is_cloudy(val) :
    if re.match('^.*Cloudy.*$',str(val) )is not None :
        return 1
    else :
        return 0

def is_pellets(val) :
    if re.match('^.*Pellets.*$',str(val) ) is not None :
        return 1
    else :
        return 0

def new_weather_label(val) :


    if val.is_pellets == 1 :
        return 'Pellets'
    elif val.is_clear == 1 :
        return 'Clear'
    elif val.is_rain == 1 :
        return 'Rain'
    elif val.is_cloudy == 1 :
        return 'Cloudy'
    elif val.is_fog == 1 :
        return 'Fog'
    else :
        return 'Unknown'

def fix_weather_category(ndata) :
    ndata['is_clear'] = ndata['Weather'].apply(is_clear)
    ndata['is_snow'] = ndata['Weather'].apply(is_snow)
    ndata['is_fog'] = ndata['Weather'].apply(is_fog)
    ndata['is_cloudy'] = ndata['Weather'].apply(is_cloudy)
    ndata['is_pellets'] = ndata['Weather'].apply(is_pellets)
    ndata['is_rain'] = ndata['Weather'].apply(is_rain)

    return ndata


def prepare_and_clean_crime_data() :

    filename = 'crime_csv_all_years.csv'
    data = pd.read_csv(filename)
    to_string = lambda x:str(x)

    ## only data from 2016 and 2015
    data['YEAR'] = data['YEAR'].apply(to_string)
    data['YEAR'] = data['YEAR'].apply(year_specific)
    data = data.dropna(axis=0,how='any')
    #pdb.set_trace()
    ## Adding the timestamp
    data['date/time'] = data.apply(crime_datetime,axis=1)
    data['timestamp'] = data['date/time'].values.astype(np.int64)
    return data

def crime_datetime(row) :
    year = int(row['YEAR'])
    month = int(row['MONTH'])
    day = int(row['DAY'])
    hour = int(row['HOUR'])
    return datetime.datetime(year,month,day,hour,0,0)

def image_datetime(row) :
    year = int(row['year'])
    month = int(row['month'])
    day = int(row['day'])
    hour = int(row['hour'])

    return datetime.datetime(year,month,day,hour,0,0)

def prepare_image_data(IMAGE_DIR) :


    contents = os.listdir(IMAGE_DIR)
    filenames = pd.DataFrame(contents,columns=['title'])


    filenames['year'] = filenames['title'].str.extract('katkam-([0-9]{4}).*\.jpg')
    filenames['month'] = filenames['title'].str.extract('katkam-[0-9]{4}([0-9]{2}).*\.jpg')
    filenames['day'] = filenames['title'].str.extract('katkam-[0-9]{4}[0-9]{2}([0-9]{2}).*\.jpg')
    filenames['hour'] = filenames['title'].str.extract('katkam-[0-9]{4}[0-9]{2}[0-9]{2}([0-9]{2}).*\.jpg')

    filenames['timestamp'] = filenames.apply(image_datetime,axis=1)
    return filenames



def main() :

    WEATHER_DIR = sys.argv[1]

    data = prepare_weather_data(WEATHER_DIR)

    ## WEATHER DATA
    c = [i for i in data.columns if data.loc[:,i].count() != 0  and i!= 'Hmdx']
    ndata = data[c]
    ndata['Date/Time'] = ndata['Date/Time'].apply(to_datetime)
    ndata['timestamp'] = ndata['Date/Time'].values.astype(np.int64)
    ndata = fix_weather_category(ndata)

    # labeled data and unlabeled data {unlabeled where weather is Nan}
    ldata = ndata[ndata['Weather'].isnull() == 0]
    ldata['new_weather'] = ldata.apply(new_weather_label,axis=1)

    udata = ndata[ndata['Weather'].isnull() == 1]

    ## CRIME DATA
    cdata = prepare_and_clean_crime_data()

    ## IMAGE DATA
    IMAGE_DIR = 'image_data/katkam-scaled'
    idata = prepare_image_data(IMAGE_DIR)

    ## WEATHER AND CRIME DATA
    wcdata = ldata.merge(cdata,on='timestamp')
    #print(idata.head())

    ## WEATHER AND IMAGE DATA
    widata = ldata.merge(idata,on='timestamp')
    print('full weather data:{}'.format(ndata['Date/Time'].count()))
    print('labeled weather data:{}'.format(ldata['Date/Time'].count()))
    print('unlabelled weather data:{}'.format(udata['Date/Time'].count()))
    print('crime data:{}'.format(cdata['date/time'].count()))
    print('image data:{}'.format(idata['title'].count()))
    print('weather and crime data:{}'.format(wcdata['timestamp'].count()))
    print('weather and image data:{}'.format(widata['timestamp'].count()))

if __name__ == '__main__' :
    main()
