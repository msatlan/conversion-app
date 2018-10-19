//
//  ExchangeRatesAPI.swift
//  ConversionApp
//
//  Created by Marko Satlan on 19/10/2018.
//  Copyright © 2018 Marko Satlan. All rights reserved.
//

import Foundation

class ExchangeRatesAPI {
    
    static func fetchExchangeRates(completion: @escaping(([ExchangeRate]?, Error?)->())) {
        let url = URL(string: "http://hnbex.eu/api/v1/rates/daily/")!
        let session = URLSession.shared
        var dataTask: URLSessionDataTask?
        
        dataTask = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                print("error")
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let jsonData = data {
                
                let decoder = JSONDecoder()
                let exchangeRates = try! decoder.decode([ExchangeRate].self, from: jsonData)
                
                completion(exchangeRates, nil)
            } else {
                let error = NSError(domain: "API error", code: 0, userInfo: [:])
                completion(nil, error)
            }
        })
        dataTask?.resume()
    }
    
}
