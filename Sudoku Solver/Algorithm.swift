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
    
    
    /**
     This constructor is a constructor that runs the algorithm on a sample sudoku puzzle
    */
    init() {
        print("Algorithm Started")
        rowArray = Array(count: 9, repeatedValue: 0)
        colArray = Array(count: 9, repeatedValue: 0)
        gridArray = Array(count: 9, repeatedValue: 0)
        SudokuSolver(sudokupuzzle1, row: 0, col: -1)
        constructCandidates(sudokupuzzle, row: 0, col: 8, candidates: &testCandidates)
    }
    
    /**
     This constructor is a constructor that runs the algorithm on the parameter
    */
    init(board: [[Int]]) {
        sudokupuzzle = board
        print("Algorithm Started")
        rowArray = Array(count: 9, repeatedValue: 0)
        colArray = Array(count: 9, repeatedValue: 0)
        gridArray = Array(count: 9, repeatedValue: 0)
        SudokuSolver(sudokupuzzle, row: 0, col: -1)
    }
    
    /**
     Prints "Algorithm FInished" when the class is deintiliazed.
    */
    deinit {
        print("Algorithm Finished")
    }
    
    /**
     Main algorithm that solves a board intialized with sudoku numbers with 0 in the empty spaces
     board: sudoku grid
     row: row number algorithm is on
     col: column number algorithm is on
    */
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
                var stackCandidates: [Int] = Array(count: 9, repeatedValue: 0)
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
    
    /**
     Checks if the algorith is at the end of the board 
     row: row number algorithm is on
     col: column number algorithm is on
    */    
    func isSolution(row: Int, col: Int) -> Bool {
        return (row == 8 && col == 8)
    }
    
    /**
     Prints the board solution. 
     Primarily used for debugging
    */
    func printSolution(board: [[Int]]) {
        print("Solution:")
        for (var i = 0; i < 9; i++) {
            for (var j = 0; j < 9; j++) {
                print(board[i][j], terminator: "")
            }
            print("\n")
        }
    }
    
    /**
     Resets the arrays
    */
    func clearArrays() {
        rowArray = Array(count: 9, repeatedValue: 0)
        colArray = Array(count: 9, repeatedValue: 0)
        gridArray = Array(count: 9, repeatedValue: 0)
    }
    
    /**
     Constructs individual candidates per row/col it is currently on. Essentially at every position
     on the board, there can only be a certain number of valid values that can be in that position.
     Calls multipler helper methods to create candidates
     
     board: The sudoku puzzle method is working on
     row: row number algorithm is on
     col: column number algorithm is on
     return: Int value for amount of candidates
     */
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
    /**
     Searches array for n
     set: array to search for
     n: value to search for
     return: returns if that n is in the set
     */
    func searchArray(set: [Int], n: Int) -> Bool {
        for (var i = 0; i < set.count; i++) {
            if (set[i] == n) {
                return true
            }
        }
        return false
    }
    
    /**
     Shrinks the array for extra 0 values. 
     Saves memory
     set: the reference to the array that we are changing
    */
    func shrinkArray(inout set: [Int]) {
        for (var i = 0; i < set.count; i++) {
            if (set[i] == 0) {
                set.removeAtIndex(i)
            }
        }
    }
    
    /**
     creates candidates for the row
     board: checks the sudoku board for candidates in the row
     row: the row position the method is run on
     return: number of candidates
    */
    func rowSet(board:[[Int]], row: Int) -> Int {
        var count = 0
        for (var i = 0; i < 9; i++) {
            if (board[row][i] != 0) {
                rowArray[count] = board[row][i]
                count++
            }
        }
        
        shrinkArray(&rowArray)
        return count
    }
    
    /**
     creates candidates for the column
     board: checks the sudoku board for candidates in the column
     col: the column position the method is run on
     return: number of candidates
     */
    func colSet(board:[[Int]], col: Int) -> Int {
        var count = 0
        for (var i = 0; i < 9; i++) {
            if (board[i][col] != 0) {
                colArray[count] = board[i][col]
                count++
            }
        }
        shrinkArray(&colArray)
        return count;
    }
    
    /**
     creates candidates for the 3x3 grid
     board: checks the sudoku board for candidates in the 3x3 grid
     row: the row position the method is run on
     col: the column position the method is run on
     return: number of candidates
     */
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
            shrinkArray(&gridArray)
            return count
    }
    
}