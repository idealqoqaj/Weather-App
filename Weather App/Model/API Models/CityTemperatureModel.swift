//
//  CityTemperatureModel.swift
//  Weather App
//
//  Created by Ideal Cocaj on 5.5.21.
//

import Foundation
import ObjectMapper

class CityTemperatureModel: Mappable {
    
    let kWeatherText = "WeatherText"
    let kWeatherIcon = "WeatherIcon"
    let kIsDayTime = "IsDayTime"
    let kTemperature = "Temperature"
    
    //Properties
    var weatherText: String?
    var weatherIcon: Int?
    var isDayTime: Bool?
    var temperature: TemperatureModel?
    
    required init?(map: Map) {
        

    }
    
    func mapping(map: Map) {
        self.weatherText <- map[kWeatherText]
        self.weatherIcon <- map[kWeatherIcon]
        self.isDayTime  <- map[kIsDayTime]
        self.temperature <- map[kTemperature]
    }
}
