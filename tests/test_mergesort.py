from tests.test_algorithm import TestAlgorithm
import unittest

from .context import algorithms
from algorithms.mergesort import MergeSort

class TestMergeSort(TestAlgorithm, unittest.TestCase):
    @staticmethod
    def the_tested_class():
        return MergeSort

