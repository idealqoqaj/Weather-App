//
//  TemperatureValueModel.swift
//  Weather App
//
//  Created by Ideal Cocaj on 5.5.21.
//

import Foundation
import ObjectMapper

class TemperatureValueModel: Mappable {
    
    let kValue = "Value"
    let kUnit = "Unit"
    let kUnitType = "UnitType"
    
    //Properties
    var value: Double?
    var unit: String?
    var unitType: Int?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        self.value <- map[kValue]
        self.unit <- map[kUnit]
        self.unitType <- map[kUnitType]
    }
    
    
}
