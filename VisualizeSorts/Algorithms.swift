//
//  Algorithms.swift
//  VisualizeSorts
//
//  Created by Kimberly Brewer on 12/9/23.
//

import Foundation

extension Array where Element: Comparable {
    mutating func bubbleSort() {
        for index in 0..<count - 1 {
            if self[index] > self[index + 1] {
                swapAt(index, index + 1)
            }
        }
    }
    mutating func insertionSort(startPos: Int) -> Int {
        guard startPos < count else { return startPos}
        let itemToPlace = self[startPos]
        var currentItemIndex = startPos
        while currentItemIndex > 0 && itemToPlace < self[currentItemIndex - 1] {
            // while we can go backwards, lets go backwards
            self[currentItemIndex] = self[currentItemIndex - 1]
            currentItemIndex -= 1
        }
        // now its in the correct position, place it there
        self[currentItemIndex] = itemToPlace
        return startPos + 1
    }
    // this is a non recursive verion
    mutating func quickSort() {
        guard count > 1 else { return } // then its already sorted
        let pivot = self[Int.random(in: 0..<count)]
        let before = self.filter { $0 < pivot } // change to var to make recursive
        let after = self.filter { $0 > pivot } // change to var to make recursive
        let equal = self.filter { $0 == pivot }
        // add to make recursive
        // before.quickSort()
        // after.quickSort()
        // end add to make recursive
        self = before + equal + after
    }
}
