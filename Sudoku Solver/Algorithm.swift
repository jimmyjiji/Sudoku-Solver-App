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
    var sudokupuzzle = [[3,0,6,8,0,0,5,0,0], [0,8,0,0,6,1,0,2,0], [5,0,0,0,3,0,0,0,7], [0,4,0,3,1,7,0,0,5], [0,9,8,4,0,6,3,7,0], [7,0,0,2,9,8,0,4,0], [8,0,0,0,4,0,0,0,9], [0,3,0,6,2,0,0,1,0], [0,0,5,0,0,9,6,0,0]]
    var sudokupuzzle1 = [[9,0,6,0,7,0,4,0,3], [0,0,0,4,0,0,2,0,0], [0,7,0,0,2,3,0,1,0], [5,0,0,0,0,0,1,0,0] , [0,4,0,2,0,8,0,6,0], [0,0,3,0,0,0,0,0,5], [0,3,0,7,0,0,0,5,0], [0,0,7,0,0,5,0,0,0], [4,0,5,0,1,0,7,0,8]]
    var finished = false
    var testCandidates = [0,0,0,0,0,0,0,0,0]
    
    init() {
        print("Algorithm Started")
        rowArray = [0,0,0,0,0,0,0,0,0]
        colArray = [0,0,0,0,0,0,0,0,0]
        gridArray = [0,0,0,0,0,0,0,0,0]
        SudokuSolver(sudokupuzzle1, row: 0, col: -1)
        //constructCandidates(sudokupuzzle, row: 0, col: 8, candidates: &testCandidates)
    }
    
    init(board: [[Int]]) {
        sudokupuzzle = board
        print("Algorithm Started")
        rowArray = [0,0,0,0,0,0,0,0,0]
        colArray = [0,0,0,0,0,0,0,0,0]
        gridArray = [0,0,0,0,0,0,0,0,0]
        SudokuSolver(sudokupuzzle, row: 0, col: -1)
    }
    
    deinit {
        print("Algorithm Finished")
    }
    
    func SudokuSolver(var board: [[Int]], var row: Int, var col: Int) {
        if (isSolution(row, col:col)) {
            printSolution(board)
            finished = true
        } else {
            col += 1
            if (col > 8) {
                row += 1
                col = 0
            }
            
            if (board[row][col] != 0) {
                SudokuSolver(board, row: row, col: col)
            } else {
                var stackCandidates: [Int] = [0,0,0,0,0,0,0,0,0]
                let candidateLength: Int = constructCandidates(board, row: row, col: col, candidates: &stackCandidates)
                for (var i = 0; i < candidateLength; i++) {
                    board[row][col] = stackCandidates[i]
                    SudokuSolver(board, row: row, col: col)
                    board[row][col] = 0
                    if (finished) {
                        return
                    }
                }
            }
        }
    }
    
    func isSolution(row: Int, col: Int) -> Bool {
        return (row == 8 && col == 8)
    }
    
    func printSolution(board: [[Int]]) {
        print("Solution:")
        for (var i = 0; i < 9; i++) {
            for (var j = 0; j < 9; j++) {
                print(board[i][j], terminator: "")
            }
            print("\n")
        }
    }
    
    func clearArrays() {
        rowArray = [0,0,0,0,0,0,0,0,0]
        colArray = [0,0,0,0,0,0,0,0,0]
        gridArray = [0,0,0,0,0,0,0,0,0]
    }
    
    func constructCandidates(board: [[Int]], row: Int, col: Int, inout candidates: [Int]) -> Int{
        var count = 0
        
        clearArrays()
        rowSet(board, row: row)
        colSet(board, col: col)
        gridSet(board, row: row, col: col)
        
        for (var i = 1; i <= 9; i++) {
            if (searchArray(rowArray, n: i)) {
                continue
            }
            if (searchArray(colArray, n: i)) {
                continue
            }
            if (searchArray(gridArray, n: i)) {
                continue
            }
            candidates[count] = i
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