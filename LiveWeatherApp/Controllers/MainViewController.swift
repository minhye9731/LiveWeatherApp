//
//  MainViewController.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import UIKit
import MapKit
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet var configureUIViews: [UIView]!
    
    @IBOutlet weak var locationImage: UIImageView!
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
    
    var data: WeatherModel = WeatherModel(icon: "", weather: "", weatherDetail: "", temperature: 0.0, temperatureFeel: 0.0, temperatureMin: 0.0, temperatureMax: 0.0, humidity: 0, windSpeed: 0.0, windDeg: 0, country: " ", cityname: " ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        self.navigationItem.title = ""
        setNavigationBar()
        
        fetchWeatherData(type: .image)
        
        configureImage()
        setLabelUI()
        setViewUI()
        setButtonUI()
        
        
    }
    
    func configureImage() {
        
        locationImage.image = UIImage(systemName: ImageName.location.rawValue)
        locationImage.tintColor = .black
        
        weatherIconUIImage.contentMode = .scaleAspectFill
        
        temperatureIconUIImage.image = UIImage(systemName: ImageName.temperature.rawValue)
        temperatureIconUIImage.tintColor = .black
        
        humidityIconUIImage.image = UIImage(systemName: ImageName.humidity.rawValue)
        humidityIconUIImage.tintColor = .black
        
        windIconUIImage.image = UIImage(systemName: ImageName.wind.rawValue)
        windIconUIImage.tintColor = .black
    }
    func configureLabel(data: WeatherModel) {
        
        currentLocationLabel.text = "\(data.country), \(data.cityname)"
        currentLocationLabel.font = .boldSystemFont(ofSize: 24)
        currentLocationLabel.textColor = .black
        
        mainWeatherLabel.text = data.weather
        mainWeatherLabel.font = .boldSystemFont(ofSize: 18)
        mainWeatherLabel.textColor = .black
        
        descriptionWeatherLabel.text = data.weatherDetail
        descriptionWeatherLabel.font = .boldSystemFont(ofSize: 14)
        descriptionWeatherLabel.textColor = .systemGray2
        
        currentTemperatureLabel.text = "\(data.temperature)º"
        currentTemperatureLabel.font = .boldSystemFont(ofSize: 18)
        currentTemperatureLabel.textColor = .black
        
        minmaxTemperatureLabel.text = "\(data.temperatureMin)º ~ \(data.temperatureMax)º"
        minmaxTemperatureLabel.font = .systemFont(ofSize: 14)
        minmaxTemperatureLabel.textColor = .systemGray2
        
        feelTemperatureLabel.text = "(체감: \(data.temperatureFeel)º)"
        feelTemperatureLabel.font = .systemFont(ofSize: 12)
        feelTemperatureLabel.textColor = .systemBlue
        
        currentHumidityLabel.text = "\(data.humidity)%"
        currentHumidityLabel.font = .boldSystemFont(ofSize: 18)
        currentHumidityLabel.textColor = .black
        
        currentWindSpeedLabel.text = "\(data.windSpeed)m/s"
        currentWindSpeedLabel.font = .boldSystemFont(ofSize: 18)
        currentWindSpeedLabel.textColor = .black
        
        currentWindDegLabel.text = "degree: \(data.windDeg)"
        currentWindDegLabel.font = .systemFont(ofSize: 14)
        currentWindDegLabel.textColor = .systemGray2
    }
    func setLabelUI() {
        for label in weatherBackgroundUIView {
            label.layer.cornerRadius = 8
            label.backgroundColor = .white
        }
    }
    func setViewUI() {
        for view in configureUIViews {
            view.backgroundColor = .clear
        }
        mapView.layer.cornerRadius = 8
        
    }
    func setButtonUI() {
        downscrollButton.setImage(UIImage(systemName: ImageName.down.rawValue), for: .normal)
        downscrollButton.addTarget(self, action: #selector(pageDown), for: .touchUpInside)
        downscrollButton.backgroundColor = .clear
        downscrollButton.tintColor = .black
    }
    
    @objc func pageDown() {
        print("상세페이지로 이동!")
    }
    
    // MARK: - API 통신 (weather api)
    // 여기에 위도경도 데이터를 매개변수로 넣어야해
    func fetchWeatherData(type: Endpoint) {
        
        WeatherAPIManager.shared.fetchWeatherAPI(type: .data, latitude: 37.779507, longitude: 128.877476) { weatherData in
            
            self.data = weatherData
            
            let url = URL(string: type.requestURL + "\(self.data.icon)@2x.png")
            self.weatherIconUIImage.kf.setImage(with: url)
            
            self.configureLabel(data: self.data)
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

