from typing import Any, Dict

import numpy as np
import pandas as pd
# import tensorflow
from keras import backend, layers, models
from keras.layers import LSTM, Activation, Bidirectional, Dense, Dropout
from keras.models import Sequential
from scipy.optimize import curve_fit  # type: ignore
from scipy.signal import savgol_filter  # type: ignore
from scipy.signal import find_peaks
from sklearn.preprocessing import MinMaxScaler
# from tensorflow import keras


def process_data(model, am_id, data):
    response = {}

    scaler = MinMaxScaler()

    data = np.asarray(data, dtype=np.float32)
    data = data.reshape(-1, 16)

    y_pred = model.predict(scaler.fit_transform(data))

    response = {
        'result':
        scaler.inverse_transform(y_pred)
    }

    return response
