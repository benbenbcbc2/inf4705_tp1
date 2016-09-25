from algorithm import *

def bucketSort(items, minimum, maximum, recursive_threshold):
    itemRange = maximum-minimum
    if len(items) < 2 or itemRange < 2 :
        return items
    elif len(items) < recursive_threshold:
        return insertion_sort(items)
    else:
        limitation = min(len(items), itemRange)
        buckets = [[] for x in range(limitation+1)]
        for item in items:
            buckets[int((item-minimum)/itemRange * limitation)].append(item)
        sortItems = []
        for i in range(0,limitation):
            sortItems.extend(bucketSort(buckets[i], int(i*itemRange/limitation+minimum), int((i+1)*itemRange/limitation+minimum), recursive_threshold))
        sortItems.extend(buckets[limitation])
        return sortItems


class Bucketsort(SortingAlgorithm):
    name = "bucket"

    def _sort_fast(self, items, recursive_threshold):
        return bucketSort(items,min(items),max(items),recursive_threshold)
