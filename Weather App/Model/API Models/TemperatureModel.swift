//
//  TemperatureModel.swift
//  Weather App
//
//  Created by Ideal Cocaj on 5.5.21.
//

import Foundation
import ObjectMapper

class TemperatureModel: Mappable {
    
    let kMetric = "Metric"
    let kImperial = "Imperial"

    
    //Properties
    var metric: TemperatureValueModel?
    var imperial: TemperatureValueModel?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.metric <- map[kMetric]
        self.imperial <- map[kImperial]
       
    }
    
    
}
