import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import unittest
import os
import re

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



def main() :

    WEATHER_DIR = sys.argv[1]
    sample_filename =  os.path.join(WEATHER_DIR,'weather-51442-201605.csv')
    print('MAIN FUNCTIONS')


class weather_function_tests(unittest.TestCase) :

    def test_prepare_weather_data(self) :
        FILENAME = 'weather/weather-51442-201605.csv'
        x = gather_station_details(FILENAME)
        #print(x)


if __name__ == '__main__' :


    #main(WEATHER_DIR)
    unittest.main()
