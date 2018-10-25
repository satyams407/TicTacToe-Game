//
//  AppUtility.swift
//  MutualMobileCodingTest
//
//  Created by Satyam Sehgal on 25/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

class AppUtility {

    enum gridNumber: Int {
        case maxGridSize = 10
        case minGridSize = 2
    }
 
    static func showAlert(title: String? = StringConstants.emptyString, message: String, onController controller: UIViewController) {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            let dismissAction  = UIAlertAction.init(title: StringConstants.okButtonTitle, style: .cancel, handler: nil)
            alert.addAction(dismissAction)
            controller.present(alert,animated: true, completion: nil)
    }

    static func validateGridSize(size: Int) -> Bool {
        return (size > gridNumber.minGridSize.rawValue && size < gridNumber.maxGridSize.rawValue)
    }

}
