import abc

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
