import abc
from bisect import *

class SortingAlgorithm(metaclass=abc.ABCMeta):
    name = ""

    def __init__(self, threshold=1, name=""):
        self.threshold = threshold
        if name:
            self.name = name

    def sort_fast(self, items, recursive_threshold=0):
        if not recursive_threshold:
            recursive_threshold = self.threshold
        return self._sort_fast(items, recursive_threshold)

    @abc.abstractmethod
    def _sort_fast(self, items, recursive_threshold):
        pass

    def sort(self, items):
        return self.sort_fast(items, recursive_threshold=1)

    def get_name(self):
        return self.name

class PythonSort(SortingAlgorithm):
    name = "python"

    def _sort_fast(self, items, recursive_threshold):
        return sorted(items)

def insertion_sort(items):
    res = []
    for i in items:
        added = False
        for pos, r in enumerate(res):
            if i < r:
                res.insert(pos, i)
                added = True
                break
        if not added:
            res.append(i)
    return res

def insertion_sort_fast(items):
    res = []
    for i in items:
        insort(res, i)
    return res

class InsertionSort(SortingAlgorithm):
    name = "insertion"

    def _sort_fast(self, items, recursive_threshold):
        return insertion_sort(items)
