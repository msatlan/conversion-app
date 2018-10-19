//
//  CurrencyRate+CoreDataProperties.swift
//  ConversionApp
//
//  Created by Marko Satlan on 19/10/2018.
//  Copyright © 2018 Marko Satlan. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrencyRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyRate> {
        return NSFetchRequest<CurrencyRate>(entityName: "CurrencyRate")
    }

    @NSManaged public var buyingRate: Float
    @NSManaged public var currencyCode: String?
    @NSManaged public var medianRate: Float
    @NSManaged public var sellingRate: Float
    @NSManaged public var unitValue: Int32

}
