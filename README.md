# Weather Predictions

## Objectives
This repository have the machine-learning workflow for predicting the labels for primary weather data set from GHCN [1]. To be specific 

•	To predict the weather of Vancouver downtown for years 2016 and 2017 hourly for all days in this time-span. The labelling means using a weather-description word such as Clear or Windy to denote the conditions at a certain provided time. 

•	To find the relationship between the weather and occurrence of certain crime-scenes around the lower-mainland Vancouver. 

## Technical Information
The workflow is written in Python3-3.6.2 version. To setup the enviornment with dependencies required to run the code first install conda[2]. After cloning the rep, go to the main-folder and run this command.

```javascript
conda create -n cmpt318_wp
```
Then activating the conda enviornment 
```javascript
source activate cmpt318_wp
```

It would create a virtual enviornment so that we can isolate it from the computer's global python dependencies. The dependencies can be found in *requirments.txt . *Now you can use conda to install all the dependencies listed in requirements.txt

```javascript
pip3 install -r requirements.txt --no-index --find-links file:///tmp/packages
```
It should follow the output like this. In my case, I have the libraries that's why it shows Requirement already satisfied. For people who don't they will have a prompt, press 'y' and it will install

```javascript
Requirement already satisfied: appnope==0.1.0 in /usr/local/lib/python3.6/site-packages (from -r requirements.txt (line 1))
Requirement already satisfied: bleach==1.5.0 in /usr/local/lib/python3.6/site-packages (from -r requirements.txt (line 2))
Requirement already satisfied: cffi==1.9.1 in /usr/local/lib/python3.6/site-packages (from -r requirements.txt (line 3))
Requirement already satisfied: constantly==15.1.0 in /usr/local/lib/python3.6/site-packages (from -r requirements.txt (line 4))
 ...
```


Now we have all the dependencies needed to run the appropriate file.

## Usage
To actually execute the code, in the home folder again write : 
```javascript
python3 weather_predict.py
```

and it will be going to take time to execute because the code internally is reading, performing processing and then evaluating the models. Training the models especially takes time depending upon the size of data as well as the model selected. You should expect the output to be like this : 

```javascript
...
Decision Tree : 0.6342067900618715
Log Regression : 0.6990093797341871
Bernoulli : 0.6904244901467512

CROSSVALIDATION with Shuffling------------------------------
Naive Bayes : 0.40880560420315243
KNeighbors : 0.754984238178634
...
```

## Reading Output

The output contains the cross-validation method and different trained models and their respective accuracies on prediction using test-set. 

## Improvement
To Actually understand the data, Please go to the project's wiki. I have documented the whole workflow and you will probably find something interesting to work more. If you have read through the code, you will come to realize that improvements can be made to uplift the accuracy further. According to me, 

•	Absence of features to link the weather and Crime. 
•	Automatic Fine-tuning of the models
•	Incorrect features extracted from the image are in downtown and color may not best represent rain, snow and pellets.

If you think this to be a challenging problem, Please feel free to fork this rep. and experiment.











