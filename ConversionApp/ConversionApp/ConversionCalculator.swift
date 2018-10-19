//
//  ConversionCalculator.swift
//  ConversionApp
//
//  Created by Marko Satlan on 19/10/2018.
//  Copyright © 2018 Marko Satlan. All rights reserved.
//

import Foundation

class ConversionCalculator {
    
    func convertCurrency(amount input: Float, rate multiplyer: Float) -> Float {
        return input * multiplyer
    }
}
