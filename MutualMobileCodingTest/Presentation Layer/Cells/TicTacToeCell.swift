//
//  TicTacToeCell.swift
//  MutualMobileCodingTest
//
//  Created by Satyam Sehgal on 25/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit


class TicTacToeCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    func updateCell(isFirstPlayer: Bool) {
        self.imageView.image = isFirstPlayer ? UIImage(named: "crossImage") : UIImage(named: "zeroImage")
    }
}
