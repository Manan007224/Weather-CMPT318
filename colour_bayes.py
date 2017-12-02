import numpy as np;
import pandas as pd;
import matplotlib.pyplot as plt;
from sklearn.preprocessing import PolynomialFeatures
from sklearn.naive_bayes import GaussianNB
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import Imputer,MinMaxScaler,FunctionTransformer
from sklearn.metrics import accuracy_score
from skimage.color import lab2rgb,rgb2lab
import sys
import warnings
from math import *
warnings.filterwarnings('ignore')

def to_lab(X) :
    x1 = X.reshape(1,-1,3)
    l = rgb2lab(x1)
    l1 = l.reshape(-1,3)
    return l1


# representative RGB colours for each label, for nice display
COLOUR_RGB = {
    'red': (255, 0, 0),
    'orange': (255, 114, 0),
    'yellow': (255, 255, 0),
    'green': (0, 230, 0),
    'blue': (0, 0, 255),
    'purple': (187, 0, 187),
    'brown': (117, 60, 0),
    'pink': (255, 187, 187),
    'black': (0, 0, 0),
    'grey': (150, 150, 150),
    'white': (255, 255, 255),
}
name_to_rgb = np.vectorize(COLOUR_RGB.get, otypes=[np.uint8, np.uint8, np.uint8])


def plot_predictions(model, lum=71, resolution=256):
    """
    Create a slice of LAB colour space with given luminance; predict with the model; plot the results.
    """
    wid = resolution
    hei = resolution
    n_ticks = 5

    # create a hei*wid grid of LAB colour values, with L=lum
    ag = np.linspace(-100, 100, wid)
    bg = np.linspace(-100, 100, hei)
    aa, bb = np.meshgrid(ag, bg)
    ll = lum * np.ones((hei, wid))
    lab_grid = np.stack([ll, aa, bb], axis=2)

    # convert to RGB for consistency with original input
    X_grid = lab2rgb(lab_grid)

    # predict and convert predictions to colours so we can see what's happening
    y_grid = model.predict(X_grid.reshape((wid*hei, 3)))
    pixels = np.stack(name_to_rgb(y_grid), axis=1) / 255
    pixels = pixels.reshape((hei, wid, 3))

    # plot input and predictions
    plt.figure(figsize=(10, 5))
    plt.suptitle('Predictions at L=%g' % (lum,))
    plt.subplot(1, 2, 1)
    plt.title('Inputs')
    plt.xticks(np.linspace(0, wid, n_ticks), np.linspace(-100, 100, n_ticks))
    plt.yticks(np.linspace(0, hei, n_ticks), np.linspace(-100, 100, n_ticks))
    plt.xlabel('A')
    plt.ylabel('B')
    plt.imshow(X_grid.reshape((hei, wid, 3)))

    plt.subplot(1, 2, 2)
    plt.title('Predicted Labels')
    plt.xticks(np.linspace(0, wid, n_ticks), np.linspace(-100, 100, n_ticks))
    plt.yticks(np.linspace(0, hei, n_ticks), np.linspace(-100, 100, n_ticks))
    plt.xlabel('A')
    plt.imshow(pixels)


def main() :

    data = pd.read_csv(sys.argv[1])
    data['nR'] = data['R']/255;
    data['nG'] = data['G']/255;
    data['nB'] = data['B']/255;


    colors = data[['nR','nG','nB','Confidence','Label']]

    c = colors[colors.Confidence=='perfect'] ## with perfect confidence
    X_rgb = c[['nR','nG','nB']].values
    y_rgb = c[['Label']].values


    # rgb model


    model_rgb = GaussianNB()

    X_rgb_train,X_rgb_test,y_rgb_train,y_rgb_test = train_test_split(X_rgb,y_rgb)
    model_rgb.fit(X_rgb_train,y_rgb_train)

    y_rgb_predicted = model_rgb.predict(X_rgb_test)
    rgb_accuracy = accuracy_score(y_rgb_test,y_rgb_predicted)

    #plot_predictions(model_rgb)
    #plt.savefig('predictions_rgb.png')


    model_lab = make_pipeline(
        FunctionTransformer(to_lab),
        GaussianNB()
    )

    model_lab.fit(X_rgb_train,y_rgb_train)

    y_lab_predicted = model_lab.predict(X_rgb_test)
    lab_accuracy = accuracy_score(y_lab_predicted,y_rgb_test)


    print(rgb_accuracy)
    print(lab_accuracy)


    ## HERE I GET THE COLOR LABELLING

    filename = 'image_data/KATKAM_colors.csv'
    data = pd.read_csv(filename,header=None)
    data.columns=['file_index','region','r','g','b']

    image_test_colour_data = data[['r','g','b']].values
    results = model_lab.predict(image_test_colour_data)

    data['color_label'] = results
    data.to_csv('image_data/KATKAM_labeled_colors.csv',index=False)

if __name__ == "__main__" :
    main()
