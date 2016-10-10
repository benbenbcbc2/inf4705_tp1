from algorithms.algorithm import *

def bucketSort(items, minimum, maximum, recursive_threshold):
    itemRange = maximum-minimum
    if len(items) < 2 or itemRange < 2 :
        return items
    elif len(items) < recursive_threshold:
        return insertion_sort(items)
    else:
        length = len(items)
        buckets = [[] for x in range(length+1)]
        for item in items:
            buckets[int((item-minimum)/itemRange * length)].append(item)
        sortItems = []
        for i in range(0,length):
            sortItems.extend(bucketSort(buckets[i], int(i*itemRange/length+minimum), int((i+1)*itemRange/length+minimum), recursive_threshold))
        sortItems.extend(buckets[length])
        return sortItems


class BucketSort(SortingAlgorithm):
    name = "bucket"

    def _sort_fast(self, items, recursive_threshold):
        if not items:
            return items
        return bucketSort(items,min(items),max(items)+1,recursive_threshold)
