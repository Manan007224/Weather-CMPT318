from sklearn.naive_bayes import GaussianNB,BernoulliNB
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.tree import DecisionTreeClassifier,export_graphviz
from sklearn.model_selection import cross_val_score,KFold,ShuffleSplit
from sklearn.feature_selection import SelectKBest, chi2,f_classif
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler,MinMaxScaler,Imputer
from sklearn.decomposition import PCA
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split,cross_val_score
import graphviz
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
import seaborn as sns
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

def date_only(row) :
    year = row['Year']
    month = row['Month']
    day = row['Day']
    return datetime.datetime(year,month,day,0,0,0)


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

def image_extracted_features_data(IMAGE_DIR,sun_present_file,average_color_file) :


    contents = os.listdir(IMAGE_DIR)
    filenames = pd.DataFrame(contents,columns=['title'])


    filenames['year'] = filenames['title'].str.extract('katkam-([0-9]{4}).*\.jpg')
    filenames['month'] = filenames['title'].str.extract('katkam-[0-9]{4}([0-9]{2}).*\.jpg')
    filenames['day'] = filenames['title'].str.extract('katkam-[0-9]{4}[0-9]{2}([0-9]{2}).*\.jpg')
    filenames['hour'] = filenames['title'].str.extract('katkam-[0-9]{4}[0-9]{2}[0-9]{2}([0-9]{2}).*\.jpg')

    filenames['timestamp'] = filenames.apply(image_datetime,axis=1)
    sun_present = pd.read_csv(sun_present_file,header=None)
    sun_present.columns =['image_index','sun_present']

    average_color = pd.read_csv(average_color_file)
    average_color.columns=['file_index','region_id','r','g','b','Label']

    sky_color = average_color[average_color['region_id']==1]
    sky_color = sky_color[['file_index','r','g','b','Label']]
    sky_color = sky_color.reset_index()
    sky_color.drop(['index'],axis=1)

    filenames['sun_present'] = sun_present['sun_present']
    filenames['sky_color_r'] = sky_color['r']
    filenames['sky_color_g'] = sky_color['g']
    filenames['sky_color_b'] = sky_color['b']
    filenames['color_label'] = sky_color['Label']

    return filenames

def plot_colorlabels_vs_sunpresent(filenames,visualization_dir) :

    ## As we can see, the gray is the highest color when sun was not present. Because the distribution is
    ## very concentrated in few results, it can affect the training dataset and later predictions.

    color_data = filenames[['color_label','sun_present']]
    color_data_sun = color_data[color_data['sun_present']==1]
    color_data_not_sun = color_data[color_data['sun_present']!=1]


    color_agg = color_data.groupby(['color_label','sun_present']).size().to_frame().reset_index()
    color_agg.columns=['color_label','sun_present','count']

    sns.factorplot(x='color_label',y='count',hue='sun_present',data=color_agg,kind='bar',size=8)

    figure_path = os.path.join(visualization_dir,'colorlabel_and_sunpresent.jpg')
    plt.savefig(figure_path)

def plot_sunpresent_vs_temp(widata,visualization_dir) :

    sun_and_temp = widata[['Temp (°C)','sun_present']]
    sun_temp_avg = sun_and_temp.groupby('sun_present').agg(np.mean)
    sun_temp_avg = sun_temp_avg.reset_index()
    sun_temp_avg['label'] = ['No Sun','Sun']

    #sns.countplot(x='sun_present',data=sun_and_temp)
    sun_temp_avg = sun_temp_avg[['label','Temp (°C)']]
    sns.barplot(x='label',y='Temp (°C)',data=sun_temp_avg).set_title('Averages of Temp (°C) on sun and non-sun days')

    figure_path = os.path.join(visualization_dir,'sunpresent_vs_temp.jpg')
    plt.savefig(figure_path)

def plot_winddir_vs_temp(ldata,visualization_dir) :

    l = ldata[['Temp (°C)','Wind Spd (km/h)']]
    ax = sns.jointplot(x=l['Temp (°C)'].values,y=l['Wind Spd (km/h)'].values,kind='hex',size=7)
    ax.set_axis_labels('Temperature(°C)','Wind Spd (km/h)')

    figure_path = os.path.join(visualization_dir,'winddir_vs_temp.jpg')
    plt.savefig(figure_path)

def plot_temp_sunpresent_weather_heatmap(widata,visualization_dir) :

    ll = widata[['new_weather','sun_present','Temp (°C)']]

    ll_pivot = ll.pivot_table(index='sun_present',columns='new_weather',values='Temp (°C)',aggfunc='mean')

    hfig,hax = plt.subplots(figsize=(15,5))
    sns.heatmap(ll_pivot,annot=True,ax=hax).set_title('Average Temperature(°C) with sun and weather')
    plt.xlabel('Weather')
    plt.ylabel('Sun Present ?')

    figure_path = os.path.join(visualization_dir,'temp_sunpresent_weather_heatmap.jpg')
    plt.savefig(figure_path)

def plot_windspeed_vs_weather(widata,visualization_dir) :

    fig,ax = plt.subplots(figsize=(10,7))
    sns.barplot(ax=ax,x='new_weather',y='Wind Spd (km/h)',data=widata)
    ax.set_xlabel('Weather conditions')
    ax.set_ylabel('Wind Speed (km/h)')
    ax.set_title('Wind Speed under different weather conditions')

    figure_path = os.path.join(visualization_dir,'windspeed_vs_weather.jpg')
    plt.savefig(figure_path)

def prepare_weatherstats_data(SNOW_FILE,widata,cdata) :

    snow_data = pd.read_csv(SNOW_FILE)
    snow_features = ['date','avg_temperature','avg_pressure_station','snow','sunlight','rain','precipitation']
    snow_data = snow_data[snow_features]
    snow_data['date_only'] = pd.to_datetime(snow_data['date'])

    ## JOINING SNOW_DATA AND JOINED_DATA
    joined_data = widata.merge(cdata,on='timestamp')

    joined_data['date_only'] = joined_data.apply(date_only,axis=1)
    joined_data = joined_data.merge(snow_data,on='date_only')

    return dict(joined=joined_data,weatherstats=snow_data)

def plot_snow_vs_colorlabel(joined_data,visualization_dir) :

    snow_color_df = joined_data[['color_label','snow']]
    snow_color_df = snow_color_df.groupby(snow_color_df['color_label']).agg(np.mean)

    sns.heatmap(snow_color_df)

    figure_path = os.path.join(visualization_dir,'snow_vs_colorlabel.jpg')
    plt.savefig(figure_path)

def plot_rain_vs_temp(joined_data,visualization_dir) :
    rain_agg = joined_data[['precipitation','color_label']]
    rain_agg = rain_agg.groupby(rain_agg['color_label']).agg(np.mean)
    rain_agg = rain_agg.reset_index(level=0)

    ax = sns.lmplot(x='Temp (°C)',y='precipitation',hue='sun_present',data=joined_data,size=7)
    ax.set_titles('asdf')
    ax.set_ylabels('Precipitation(mm)')

    figure_path = os.path.join(visualization_dir,'rain_vs_temp.jpg')
    plt.savefig(figure_path)


def prepare_train_test_data_weatherlabel(joined_data) :
    f1 = ['Temp (°C)','Dew Point Temp (°C)','Rel Hum (%)','Wind Dir (10s deg)','Wind Spd (km/h)','Visibility (km)','color_label','sun_present','avg_pressure_station','snow','sunlight','rain','new_weather']
    #f2 = ['color_label','sun_present','new_weather']
    f2 = ['Temp (°C)','Dew Point Temp (°C)','Rel Hum (%)','Wind Dir (10s deg)','Wind Spd (km/h)','Visibility (km)','color_label','sun_present','avg_pressure_station','snow','sunlight','rain','TYPE','new_weather']

    crime_joined_data = joined_data[f2]
    joined_data = joined_data[f1]
    joined_data = joined_data.dropna(axis=0,how='any')

    labeled_data_X = joined_data.loc[:,joined_data.columns!='new_weather']
    labeled_data_X = pd.get_dummies(labeled_data_X)
    #print(labeled_data_X.columns)
    labeled_data_y = joined_data['new_weather']

    return dict(x=labeled_data_X,y=labeled_data_y)


def define_models() :

    pca_n_features = 2

    scaling = make_pipeline(StandardScaler())
    fe = make_pipeline(PCA(2))

    preprocessing = make_pipeline(scaling,Imputer(missing_values="NaN",strategy="mean"))

    bayes_model = make_pipeline(preprocessing,GaussianNB())
    bayes_model.__name__ = 'Naive Bayes'

    bernolli_model = make_pipeline(preprocessing, BernoulliNB())
    bernolli_model.__name__ = 'Bernoulli'

    k = 6
    knn_model = make_pipeline(preprocessing,KNeighborsClassifier(n_neighbors=k))
    knn_model.__name__ = 'KNeighbors'

    svm_model = make_pipeline(preprocessing,SVC(kernel='linear',decision_function_shape='ovr'))
    svm_model.__name__ = 'SVM'

    tree_model = make_pipeline(preprocessing,DecisionTreeClassifier(random_state=0))
    tree_model.__name__ = 'Decision Tree'

    logreg_model = make_pipeline(preprocessing,LogisticRegression())
    logreg_model.__name__ = 'Log Regression'

    MODEL = [bayes_model,knn_model,svm_model,tree_model,logreg_model,bernolli_model]
    return MODEL


def model_evaluations(MODEL,labeled_data_X,labeled_data_y) :

    print('\nCROSSVALIDATION with folding------------------------------')
    kfold = KFold(n_splits=10)
    for m in MODEL :
        score = cross_val_score(m,labeled_data_X.values,labeled_data_y,cv=kfold)
        print('{} : {}'.format(m.__name__,score.mean()))

    print('\nCROSSVALIDATION with Shuffling------------------------------')
    shuffle = ShuffleSplit(test_size=.75,train_size=.25,n_splits=50)
    for m in MODEL :
        score = cross_val_score(m,labeled_data_X.values,labeled_data_y,cv=shuffle)
        print('{} : {}'.format(m.__name__,score.mean()))

    train_X,test_X,train_y,test_y = train_test_split(labeled_data_X,labeled_data_y)
    print('\nDIRECT MODEL EVALUATION ------------------------------')
    for m in MODEL :
        m.fit(train_X,train_y)
        s = m.score(test_X,test_y)
        print('{} : {}'.format(m.__name__,s))

def predict_unlabelled_weather(ndata,cdata,filenames,snow_data,model) :

    ## predicting missing weather values

    wiudata = ndata.merge(filenames,on='timestamp')
    ujoined_data = wiudata.merge(cdata,on='timestamp')
    ujoined_data['date_only'] = ujoined_data.apply(date_only,axis=1)
    ujoined_data = ujoined_data.merge(snow_data,on='date_only')

    ## BEST MODEL SO FAR WAS DECISION TREE (FROM MANUAL MODEL EVALUATION). so, let's predict

    features = ['Temp (°C)','Dew Point Temp (°C)','Rel Hum (%)','Wind Dir (10s deg)','Wind Spd (km/h)','Visibility (km)','color_label','sun_present','avg_pressure_station','snow','sunlight','rain']

    ujoined_data = ujoined_data[features]
    ujoined_data = ujoined_data.dropna(axis=0,how='any')

    predict_data = ujoined_data
    predict_data = pd.get_dummies(labeled_data_X)

    return model.predict(predict_data)



def main() :

    ## PATHS
    WEATHER_DIR = sys.argv[1]
    VISUALIZATION_DIR = 'visualizations'
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
    SUN_PRESENT_FILE = 'image_data/SUN_PRESENT.csv'
    KATKAM_AVERAGE_COLOR_FILE = 'image_data/KATKAM_labeled_colors2.csv'


    idata = image_extracted_features_data(IMAGE_DIR,SUN_PRESENT_FILE,KATKAM_AVERAGE_COLOR_FILE)


    ## IMAGE AND WEATHER COMBINED DATA
    widata = ldata.merge(idata,on='timestamp')

    ## IMAGE AND WEATHER AND WEATHERSTATS DATA

    SNOW_FILE = 'snow.csv'
    W = prepare_weatherstats_data(SNOW_FILE,widata,cdata)
    joined_data = W['joined']
    snow_data = W['weatherstats']

    ## PRODUCING VISUALIZATIONS

    plot_colorlabels_vs_sunpresent(idata,VISUALIZATION_DIR)
    plot_sunpresent_vs_temp(widata,VISUALIZATION_DIR)
    plot_winddir_vs_temp(ldata,VISUALIZATION_DIR)
    plot_temp_sunpresent_weather_heatmap(widata,VISUALIZATION_DIR)
    plot_windspeed_vs_weather(widata,VISUALIZATION_DIR)
    plot_snow_vs_colorlabel(joined_data,VISUALIZATION_DIR)
    plot_rain_vs_temp(joined_data,VISUALIZATION_DIR)

    ## PRODUCING TRAIN TESTING DATA TO PREDICT WEATHER LABELLING

    D = prepare_train_test_data_weatherlabel(joined_data)
    weather_unlabeled_data_X = D['x']
    weather_unlabeled_data_y = D['y']


    ## DEFINE MODELS

    models = define_models()

    ## FIT AND EVALUATE MODELS USING SIMPLE TEST_TRAIN AND CROSS VALIDATION
    model_evaluations(models,weather_unlabeled_data_X,weather_unlabeled_data_y)


    ## DECISION TREE TURNS OUT THE BE BEST MODEL WITH ACCURANCY 0.88
    best_model = models[3]
    missing_labels = predict_unlabelled_weather(ndata,cdata,idata,snow_data,best_model)
    
    ## ERROR : NameError: name 'labeled_data_X' is not defined

    #print('full weather data:{}'.format(ndata['Date/Time'].count()))
    #print('labeled weather data:{}'.format(ldata['Date/Time'].count()))
    #print('unlabelled weather data:{}'.format(udata['Date/Time'].count()))
    #print('crime data:{}'.format(cdata['date/time'].count()))
    #print('image data:{}'.format(idata['title'].count()))
    #print('weather and crime data:{}'.format(wcdata['timestamp'].count()))
    #print('weather and image data:{}'.format(widata['timestamp'].count()))




if __name__ == '__main__' :
    main()
