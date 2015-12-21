//
//  Algorithm.swift
//  Sudoku Solver
//
//  Created by Jimmy Ji on 12/21/15.
//  Copyright © 2015 Jimmy Ji. All rights reserved.
//

import Foundation

class Algorithm {
    
    var rowArray : [Int]
    var colArray : [Int]
    var gridArray : [Int]
    var candidatesArray : [Int]
    
    init() {
        rowArray = [0]
        colArray = [0]
        gridArray = [0]
        candidatesArray = [0]
    }
    
    deinit {
        print("Popped candidates off stack")
    }
    
    func isSolution(row: Int, col: Int) -> Bool {
        return (row == 8 && col == 8)
    }
    
    func printSolution(board: [[Int]]) {
        print("Solution:")
        for (var i = 0; i < 9; i++) {
            for (var j = 0; j < 9; j++) {
                print(board[i][j])
            }
            print("\n")
        }
    }
    
    func constructCandidates(board: [[Int]], row: Int, col: Int, candidates: [Int]) -> Int{
        var count = 0
        
        rowSet(board, row: row)
        colSet(board, col: col)
        gridSet(board, row: row, col: col)
        
        for (var i = 1; i <= 9; i++) {
            if (searchArray(rowArray, n: i)) {
                break
            }
            if (searchArray(colArray, n: i)) {
                break
            }
            if (searchArray(gridArray, n: i)) {
                break
            }
            candidatesArray[count] = i
            count++
            
        }
        
        return count
    }
    
    func searchArray(set: [Int], n: Int) -> Bool {
        for (var i = 0; i < set.count; i++) {
            if (set[i] == n) {
                return true
            }
        }
        return false
    }
    
    func rowSet(board:[[Int]], row: Int) -> Int {
        var count = 0
        for (var i = 0; i < 9; i++) {
            if (board[row][i] != 0) {
                rowArray[count] = board[row][i]
                count++
            }
        }
        return count
    }
    
    func colSet(board:[[Int]], col: Int) -> Int {
        var count = 0
        for (var i = 0; i < 9; i++) {
            if (board[i][col] != 0) {
                colArray[count] = board[i][col]
                count++
            }
        }
        return count;
    }
    
    func gridSet(board:[[Int]], row: Int, col: Int) -> Int{
            let r_start: Int = row / 3 * 3; //Grids start at rows 0,3,6
            let c_start: Int = col / 3 * 3; //Grids start at cols 0,3,6
            var count = 0;
            for (var i = r_start; i < r_start + 3; i++) {
                for (var j = c_start; j < c_start + 3; j++) {
                    if (board[i][j] != 0) {
                        gridArray[count] = board[i][j];
                        count++;
                    }
                }
            }
            return count
    }
    
    
    
    
    
    
    
}