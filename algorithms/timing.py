import time

def time_algo(algo, items, amortization, threshold=None):
    """Time a sorting algorithm

    The cost of the time probes is amortized over the number of
    executions specified by the amortization parameter.

    The function returns both the average time of execution and the
    sorted items.

    """
    start = time.process_time()
    for _ in range(amortization):
        sorted_items = algo.sort_fast(items,
                                      recursive_threshold=threshold)
    stop = time.process_time()
    elapsed = stop - start
    average = elapsed / amortization
    return (average, sorted_items)
