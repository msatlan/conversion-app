//
//  ViewController.swift
//  ConversionApp
//
//  Created by Marko Satlan on 19/10/2018.
//  Copyright © 2018 Marko Satlan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
// MARK: - Properties
    var managedContext: NSManagedObjectContext!
    let conversionCalculator = ConversionCalculator()
    
    let fromCurrencyPickerView = UIPickerView()
    let toCurrencyPickerView = UIPickerView()
    let pickerValues: [String] = ["KN","AUD","CAD","CZK","DKK","HUF","JPY","NOK","SEK","CHF","GBP","USD","BAM","EUR","PLN"]
    
    var activeTextField = UITextField()
    
    var rate: ExchangeRate!
    var result: Float = 0
    
    // @IBOutlet
    @IBOutlet weak var moneyAmountTextField: UITextField!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    
// MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        ExchangeRatesAPI.fetchExchangeRates { exchangeRates, error in
            if let rates = exchangeRates,
                error == nil {
                self.rate = rates.filter{ $0.currencyCode == "AUD" }.first
                
                self.result = self.conversionCalculator.convertCurrency(amount: 1, rate: self.rate.medianRate)
                
                print(self.result)
            }
        }
    }

    func configureUI() {
        fromCurrencyPickerView.delegate = self
        fromCurrencyPickerView.tag = 100
        
        toCurrencyPickerView.delegate = self
        toCurrencyPickerView.tag = 101
        
        fromCurrencyTextField.text = "KN"
        fromCurrencyTextField.inputView = fromCurrencyPickerView
        
        toCurrencyTextField.inputView = toCurrencyPickerView
        
        moneyAmountTextField.keyboardType = .numberPad
    }
    
    @IBAction func convertCurrency(_ sender: Any) {
        if let amountOfMoney = moneyAmountTextField.text {
            let amountFloat = Float(amountOfMoney)
            result = conversionCalculator.convertCurrency(amount: amountFloat!, rate: rate.medianRate)
            resultTextField.text = String(result)
        }
        moneyAmountTextField.resignFirstResponder()
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 100 {
            fromCurrencyTextField.text = pickerValues[row]
        } else {
            toCurrencyTextField.text = pickerValues[row]
        }
        self.view.endEditing(true)
    }
}
