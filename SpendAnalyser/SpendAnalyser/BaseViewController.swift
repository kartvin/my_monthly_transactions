//
//  BaseViewController.swift
//  SpendAnalyser
//
//  Created by Karthik Kumaravel on 1/6/17.
//  Copyright © 2017 Karthik Kumaravel. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func showErrorAlert(errorMessage : String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
