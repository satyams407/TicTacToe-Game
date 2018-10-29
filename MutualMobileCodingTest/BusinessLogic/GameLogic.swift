//
//  GameLogic.swift
//  MutualMobileCodingTest
//
//  Created by Satyam Sehgal on 25/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation

class GameLogic {

    enum GameResult: Int {
      case inProgress = 1
      case firstPlayerWon
      case secondPlayerWon
      case draw
    }

    var stateOfGame: [Int] = []
    var turnCount = 0

    func setGameState(gridNumber: Int) {
        for _ in 0..<(gridNumber*2 + 2) {
            stateOfGame.append(0)
        }
    }

    func checkGameResult(gridSize: Int, index: Int, firstPlayer: Bool) -> GameResult {
        let count = firstPlayer ? 1 : -1
        let rowIndex = getRowIndex(index: index, gridSize: gridSize)
        let columnIndex = getColumnIndex(rowNumber: rowIndex, index: index, gridSize: gridSize)

        stateOfGame[rowIndex] += count
        stateOfGame[gridSize + columnIndex] += count
        if rowIndex == columnIndex {
            stateOfGame[2*gridSize] += count
        }
        if gridSize - 1 - columnIndex == rowIndex {
            stateOfGame[2*gridSize + 1] += count
        }

        turnCount += 1
        if stateOfGame.contains(gridSize) || stateOfGame.contains(-gridSize) {
            return firstPlayer ? GameResult.firstPlayerWon : GameResult.secondPlayerWon
        }

        return turnCount == (gridSize*gridSize) ? GameResult.draw : GameResult.inProgress
    }

    func getRowIndex(index: Int, gridSize: Int) -> Int {
        return index/gridSize
    }

    func getColumnIndex(rowNumber: Int, index: Int, gridSize: Int) -> Int {
        return index - rowNumber*gridSize
    }
    
}
