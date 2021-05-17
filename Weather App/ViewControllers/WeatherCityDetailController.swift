//
//  WeatherCityDetailController.swift
//  Weather App
//
//  Created by Ideal Cocaj on 15.5.21.
//

import UIKit
import IBAnimatable

class WeatherCityDetailController: UIViewController {
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var maximumTemperatureLabel: UILabel!
    @IBOutlet weak var minimumTemperatureLabel: UILabel!
    @IBOutlet weak var currentConditionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var mainWeatherIcon: AnimatableImageView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setUpCollectionView()
        
        
    }
    
    @IBAction func didPressBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpCollectionView(){
        
        collectionView.register(UINib(nibName: "HourlyWeatherCell", bundle: nil), forCellWithReuseIdentifier: "HourlyWeatherCell")
        
    }
    
    func setUpTableView(){
        
        tableView.register(UINib(nibName: "DailyWeatherCell", bundle: nil), forCellReuseIdentifier: "DailyWeatherCell")
        
    }

}

extension WeatherCityDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as? DailyWeatherCell {
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    
}

extension WeatherCityDetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as? HourlyWeatherCell {
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    
}
