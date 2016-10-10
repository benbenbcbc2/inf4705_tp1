from tests.test_algorithm import TestAlgorithm
import unittest

from .context import algorithms
from algorithms.bucketsort import BucketSort

class TestBucketSort(TestAlgorithm, unittest.TestCase):
    @staticmethod
    def the_tested_class():
        return BucketSort

