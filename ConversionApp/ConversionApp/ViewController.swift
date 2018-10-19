//
//  ViewController.swift
//  ConversionApp
//
//  Created by Marko Satlan on 19/10/2018.
//  Copyright © 2018 Marko Satlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
// MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExchangeRatesAPI.fetchExchangeRates { exchangeRates, error in
            print(exchangeRates)
        }
    }

    
}

