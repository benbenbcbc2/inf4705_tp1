from algorithms.algorithm import *

def bucketSort(items, minimum, maximum, recursive_threshold):
    item_range = maximum-minimum
    if len(items) < 2 or item_range < 2 :
        return items
    elif len(items) < recursive_threshold:
        return insertion_sort(items)
    else:
        n = min(len(items), item_range) # number of buckets
        width = item_range/n
        buckets = [[] for x in range(n)]
        for item in items:
            buckets[int((item-minimum)/width)].append(item)
        sortItems = []
        for i, b in enumerate(buckets):
            sortItems.extend(
                bucketSort(b,
                           int(i*width+minimum),
                           int((i+1)*width+minimum),
                           recursive_threshold))
        return sortItems


class BucketSort(SortingAlgorithm):
    name = "bucket"

    def _sort_fast(self, items, recursive_threshold):
        if not items:
            return items
        return bucketSort(items,min(items),max(items)+1,recursive_threshold)
