//
//  CityViewController.swift
//  Weather App
//
//  Created by Ideal Cocaj on 17.4.21.
//

import UIKit
import GooglePlaces
import Alamofire

class CityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayOfWeatherCityInfo: [WeatherCityInfoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCells()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = flowLayout

        // Do any additional setup after loading the view.
    }
    
    func registerCollectionViewCells(){
        collectionView.register(UINib(nibName: "CityCell", bundle: nil), forCellWithReuseIdentifier: "CityCell")
    }
    
    @IBAction func didPressMenuButton(_ sender: Any) {
    }
    
    @IBAction func didPressAddButton(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
           autocompleteController.delegate = self

           // Specify the place data types to return.
           let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                        UInt(GMSPlaceField.placeID.rawValue) |  UInt(GMSPlaceField.coordinate.rawValue) |  UInt(GMSPlaceField.addressComponents.rawValue))
           autocompleteController.placeFields = fields

           // Specify a filter.
           let filter = GMSAutocompleteFilter()
           filter.type = .city
           autocompleteController.autocompleteFilter = filter

           // Display the autocomplete view controller.
           present(autocompleteController, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfWeatherCityInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath) as? CityCell {
            
            let weatherCityInfo = arrayOfWeatherCityInfo[indexPath.row]
            
            cell.temperatureLabel.text = String(describing: Int(weatherCityInfo.temperature ?? 0)) + "°"
            cell.cityLabel.text = weatherCityInfo.cityName
            cell.countryLabel.text = weatherCityInfo.countryName
            cell.weatherIcon.image = UIImage(named: String(describing: weatherCityInfo.weatherIconType ?? 1))
            return cell
        }
      return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.bounds.width/2-5, height: 180)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weatherItem = arrayOfWeatherCityInfo[indexPath.item]
        if let weatherDetailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherCityDetailController") as? WeatherCityDetailController {
            self.navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
}

    

extension CityViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
    WeatherAPI.shared.getLocationKeyForCoordinates(apiKey: "SCQQQYNf6IOLiGKiGAnGCTj49mX4jFrQ", longitude: place.coordinate.longitude, latitude: place.coordinate.latitude) { (success, message, key, error) in
        if success && key != nil {
           
            WeatherAPI.shared.getTemperatureForLocationKey(apiKey: "SCQQQYNf6IOLiGKiGAnGCTj49mX4jFrQ", locationKey: key!) { (success, message, arrOfCityTemperatureModels, error) in
                if success && arrOfCityTemperatureModels.count != 0{
                    
                    let cityTemperatureModel = arrOfCityTemperatureModels[0]
                    
                    let country = place.addressComponents?.first(where: {$0.type == "country"})?.name
                    
                    let weatherCityModel = WeatherCityInfoModel (temperature: cityTemperatureModel.temperature?.metric?.value, weatherIconType: cityTemperatureModel.weatherIcon, cityName: place.name, countryName: country)
                    
                    self.arrayOfWeatherCityInfo.append(weatherCityModel)
                    
                    self.collectionView.reloadData()
                    
                }
            }
            
        }
    }
 
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
