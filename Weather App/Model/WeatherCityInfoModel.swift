//
//  WeatherCityInfoModel.swift
//  Weather App
//
//  Created by Ideal Cocaj on 8.5.21.
//

import Foundation

class WeatherCityInfoModel {
    
    var temperature: Double?
    var weatherIconType: Int?
    var cityName: String?
    var countryName: String?
    
    init(temperature: Double?, weatherIconType: Int?, cityName: String?, countryName: String?) {
        self.temperature = temperature
        self.weatherIconType = weatherIconType
        self.cityName = cityName
        self.countryName = countryName
    }
    
}
