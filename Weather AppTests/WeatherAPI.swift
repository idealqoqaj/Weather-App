//
//  WeatherAPI.swift
//  Weather App
//
//  Created by Ideal Cocaj on 28.4.21.
//

import Foundation
import Alamofire
import CoreLocation
class WeatherAPI {
    
    public static let shared = WeatherAPI()
    
    //    SCQQQYNf6IOLiGKiGAnGCTj49mX4jFrQ
    
    func getLocationKeyForCoordinates(apiKey: String, longitude: CLLocationDegrees, latitude: CLLocationDegrees, completion: @escaping(Bool, String, String?, Error?)->Void){
        let url = "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=\(apiKey)&q=\(latitude)%2C\(longitude)&details=true&toplevel=true"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case.success(let JSON):
                if let jsonDict = JSON as? [String:Any]{
                    if let key = jsonDict["Key"] as? String {
                        completion(true,"Succes", key, nil)
                    }else{
                        completion(false,"Something went wrong",nil,nil)
                    }
                }else{
                    completion(false,"Something went wrong",nil,nil)
                }
                
                break
            case.failure(let error):
                completion(false, error.localizedDescription, nil, error)
            }
            
        }
    }
    
    func getTemperatureForLocationKey(apiKey: String, locationKey: String, completion: @escaping(Bool, String, [CityTemperatureModel], Error?)->Void){
        
        let url = "http://dataservice.accuweather.com/currentconditions/v1/\(locationKey)?apikey=\(apiKey)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case.success(let JSON):
                if let arrOfJsonDict = JSON as? [[String:Any]]{
                  
                    var arrayOfCityTemperatureModels: [CityTemperatureModel] = []
                    
                    for jsonDict in arrOfJsonDict{
                        if let cityTemperatureModel = CityTemperatureModel.init(JSON: jsonDict){
                        arrayOfCityTemperatureModels.append(cityTemperatureModel)
                    }
                    }
                    
                    completion(true, "Success", arrayOfCityTemperatureModels, nil)
                                        
                }else{
                    completion(false,"Something went wrong",[],nil)
                }
                
                break
            case.failure(let error):
                
                completion(false, error.localizedDescription, [], error)
            }
            
        }
        
    }
}
