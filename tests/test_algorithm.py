from .context import algorithms
from algorithms.algorithm import *

import unittest
import abc

class TestAlgorithm(metaclass=abc.ABCMeta):
    @staticmethod
    @abc.abstractmethod
    def the_tested_class():
        pass

    def setUp(self):
        self.fix = (self.the_tested_class())()
        
    def test_sort(self):
        for t in [0, 3, 10]:
            for l in [
                    [],
                    list(range(10)),
                    list(reversed(range(10))),
                    [3, 1],
                    [243, 2652, 65254, 32, 23, 3452, 243, 243, 653344],
            ]:
                with self.subTest(l=l, t=t):
                    self.assertListEqual(self.fix.sort(l), sorted(l))

class TestInsertion(TestAlgorithm, unittest.TestCase):
    @staticmethod
    def the_tested_class():
        return InsertionSort
