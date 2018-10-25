//
//  ViewController.swift
//  MutualMobileCodingTest
//
//  Created by Satyam Sehgal on 25/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var gridNumberTextField: UITextField!
    @IBOutlet weak var gameBoardCollectionView: UICollectionView!

    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 20.0)
    var itemsPerRow: CGFloat = 3
    var firstPlayer = true // crossPlayer tag
    var isGameActive = false
    var stateOfGame: [Int]? = []
    var gridSize = 0

    let gameLogic = GameLogic()

    override func viewDidLoad() {
        super.viewDidLoad()
        gameBoardCollectionView.isHidden = true // intially hidden becz player hasn't gave grid number
    }

    // To make Adaptive across all split and orientations screen
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            DispatchQueue.main.async {
                self.gameBoardCollectionView.reloadData()
            }
        }, completion: nil)
    }

    @IBAction func playButtonAction(_ sender: UIButton) {
        guard let number = NumberFormatter().number(from: gridNumberTextField.text ?? "3" ), AppUtility.validateGridSize(size: number.intValue) else {
            AppUtility.showAlert(message: StringConstants.errorGridNumber, onController: self)
            return
        }
        gridSize = number.intValue
        itemsPerRow = CGFloat(truncating: number)
        gameBoardCollectionView.isHidden = false
        gameBoardCollectionView.reloadData()
        isGameActive = true
        firstPlayer = true
        gridNumberTextField.text = StringConstants.emptyString
        resetGameState()
    }

    func showResult(_ result: Int) {
        var message = StringConstants.emptyString
        switch result {
        case 2:
            message = StringConstants.firstPlayerWon
        case 3:
            message = StringConstants.secondPlayerWon
        default:
            message = StringConstants.gameDraw
        }
        AppUtility.showAlert(message: message, onController: self)
        resetGameState()
        gameBoardCollectionView.reloadData()
    }

    func resetGameState() {
        gameLogic.turnCount = 0
        gameLogic.stateOfGame?.removeAll()
        gameLogic.setGameState(gridNumber: gridSize)
    }
}

// MARK: CollectionView data source and delegate Methods
extension LandingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(itemsPerRow * itemsPerRow)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.gridCellIdentifier, for: indexPath)
        if let cell = collectionCell as? TicTacToeCell {
            cell.tag = 0 // intial stage of game
            cell.imageView.image = nil
        }
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TicTacToeCell, isGameActive, cell.tag == 0 {
            cell.tag = 1 // now cell is being selected
            cell.updateCell(isFirstPlayer: firstPlayer)
            let result = gameLogic.checkGameResult(gridSize: self.gridSize, index: indexPath.row, firstPlayer: firstPlayer)
            if result.rawValue > 1 {
                showResult(result.rawValue)
            }
            firstPlayer = !firstPlayer
        }
    }
}

extension LandingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // logic to write n*n grid
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1.5)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem  = availableWidth/itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
