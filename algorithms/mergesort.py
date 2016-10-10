from algorithms.algorithm import *

def merge(a, b):
    res = [None] * (len(a) + len(b))
    ia = ib = 0
    while ia < len(a) and ib < len(b):
        if a[ia] < b[ib]:
            res[ia+ib] = a[ia]
            ia += 1
        else:
            res[ia+ib] = b[ib]
            ib += 1
    return res[:ia+ib] + (a[ia:] if ia < len(a) else b[ib:])


class MergeSort(SortingAlgorithm):
    name = "merge"

    def _sort_fast(self, items, recursive_threshold):
        if len(items) < 2:
            return items
        elif len(items) < recursive_threshold:
            return insertion_sort(items)
        else:
            mid = len(items)//2
            lower = items[:mid]
            upper = items[mid:]
            sorted_lower = self._sort_fast(lower, recursive_threshold)
            sorted_upper = self._sort_fast(upper, recursive_threshold)
            return merge(sorted_lower, sorted_upper)
