//
//  CityCell.swift
//  Weather App
//
//  Created by Ideal Cocaj on 17.4.21.
//

import UIKit

class CityCell: UICollectionViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
