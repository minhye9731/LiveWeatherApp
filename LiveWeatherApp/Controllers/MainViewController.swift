//
//  MainViewController.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    @IBOutlet var configureUIViews: [UIView]!
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    @IBOutlet var weatherBackgroundUIView: [UIView]!
    
    @IBOutlet weak var weatherIconUIImage: UIImageView!
    @IBOutlet weak var mainWeatherLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    
    @IBOutlet weak var temperatureIconUIImage: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var minmaxTemperatureLabel: UILabel!
    @IBOutlet weak var feelTemperatureLabel: UILabel!
    
    @IBOutlet weak var humidityIconUIImage: UIImageView!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    
    @IBOutlet weak var windIconUIImage: UIImageView!
    @IBOutlet weak var currentWindSpeedLabel: UILabel!
    @IBOutlet weak var currentWindDegLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var downscrollButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setNavigationBar()
        self.navigationItem.title = ""

        WeatherAPIManager.shared.fetchWeatherAPI(type: .data, latitude: 37.779507, longitude: 128.877476) { result in
            print(result)
        }
        
    }
    
    
    
    
    
    

}












extension MainViewController {

    func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true // 재확인
        configureNavigationTitle()
        configureNavigationButton()
    }
    
    func configureNavigationTitle() {
        
        
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = "\(Date())" // dateformatter로 양식 재변경
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    func configureNavigationButton() {
        let uploadButton = UIBarButtonItem(image: UIImage(systemName: ImageName.upload.rawValue), style: .plain, target: self, action: nil)
        uploadButton.tintColor = .white
        uploadButton.customView?.translatesAutoresizingMaskIntoConstraints = false

        let plusButton = UIBarButtonItem(image: UIImage(systemName: ImageName.plus.rawValue), style: .plain, target: self, action: nil)
        plusButton.tintColor = .white
        plusButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        
        let settingButton = UIBarButtonItem(image: UIImage(systemName: ImageName.setting.rawValue), style: .plain, target: self, action: nil)
        settingButton.tintColor = .white
        settingButton.customView?.translatesAutoresizingMaskIntoConstraints = false

        self.navigationItem.rightBarButtonItems = [settingButton, plusButton, uploadButton]
    }
}

