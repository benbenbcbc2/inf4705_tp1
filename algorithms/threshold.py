"""Calculate, store, and retrieve the recursive thresholds

Recursive sorting algorithms are often O(n*log(n)) in time, or at
least faster than the polynomial insertion sort for large lists.
However, for smaller lists, they might have a larger constant factor
that make insertion sort a better choice. This module helps in the
determination of a threshold under which insertion sort is faster.

"""

from configparser import ConfigParser
import random

from .timing import time_algo

config_filename = "sorting.conf"

def get_threshold_config(algo_name, default=10):
    """Get the threshold for the given algorithm

    The default threshold is returned if the configuration file does
    not exist or if the key is absent from the file.

    """
    config = ConfigParser()
    config.read(config_filename)
    thresh = default
    try:
        thresh = config[algo_name].getint("threshold", default)
    except:
        pass
    return thresh

def set_threshold_config(algo_name, value):
    config = ConfigParser()
    config[algo_name]["threshold"] = value
    with open(config_filename, 'w') as configfile:
        config.write(configfile)

def timing_for_threshold(algo, thresh,
                         size=300, loops=10, amort=10,
                         seed=None):
    random.seed(a=seed)
    return sum(
        time_algo(algo, [random.randrange(size) for _ in range(size)],
                  amort, threshold=thresh)[0]
        for _ in range(loops)
    ) / loops

def calculate_optimal_threshold(algo, bot=0, top=100,
                                size=300, loops=10, amort=10,
                                seed=None):
    thresh, timed = None, None
    for test in range(bot, top):
        average = timing_for_threshold(algo, test,
                                       size, loops, amort, seed)
        if not timed or average < timed:
            thresh, timed = test, average
    return thresh
