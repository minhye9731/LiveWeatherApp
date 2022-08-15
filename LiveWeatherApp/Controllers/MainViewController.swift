//
//  MainViewController.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import UIKit
import MapKit
import Kingfisher
import CoreLocation

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
    
    let locationManager = CLLocationManager()
    var latitudeData: Double = 0.0
    var longitudeData: Double = 0.0
    var data: WeatherModel = WeatherModel(icon: "", weather: "", weatherDetail: "", temperature: 0.0, temperatureFeel: 0.0, temperatureMin: 0.0, temperatureMax: 0.0, humidity: 0, windSpeed: 0.0, windDeg: 0, country: " ", cityname: " ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        self.navigationItem.title = ""
        setNavigationBar()
        setUIAndData()
        
        locationManager.delegate = self

        let center = CLLocationCoordinate2D(latitude: 37.523844, longitude: 126.980249)
        setRegionAndAnnotation(center: center)
        fetchWeatherData(type: .image, lat: center.latitude, long: center.longitude)
        
        
    }
    
    func setUIAndData() {
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
    func fetchWeatherData(type: Endpoint, lat: Double, long: Double) {
        
        WeatherAPIManager.shared.fetchWeatherAPI(type: .data, latitude: lat, longitude: long) { weatherData in
            
            self.data = weatherData
            
            let url = URL(string: type.requestURL + "\(self.data.icon)@2x.png")
            self.weatherIconUIImage.kf.setImage(with: url)
            
            self.configureLabel(data: self.data)
        }
        
    }
    
    // MARK: - 지도내 핀설정
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "현위치"
        
        mapView.addAnnotation(annotation)
    }
}



// MARK: - CLLocationManagerDelegate 프로토콜 선언
extension MainViewController: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
            
//            self.latitudeData = coordinate.latitude
//            self.longitudeData = coordinate.longitude
//
//            fetchWeatherData(type: .image, lat: latitudeData, long: longitudeData)
            
        }
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 못 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 사용자의 권한 상태가 바뀔 경우
        // iOS 14 이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
//        // iOS 14 미만
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    checkUserDeviceLocationServiceAuthorization()
//    }
}

// MARK: - 위치 관련된 User Defined 메서드
extension MainViewController {
    
    // iOS 위치 서비스 활성화여부 확인
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
     
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
    }

    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOTDETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 위치 권한요청 팝업
            
        case .restricted, .denied:
            print("DENIED, 국립중앙박물관이 현위치가 되도록 임시 설정")
//            let center = CLLocationCoordinate2D(latitude: 37.523844, longitude: 126.980249)
//            setRegionAndAnnotation(center: center)
//            fetchWeatherData(type: .image, lat: center.latitude, long: center.longitude)
            
            
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
//            let center = CLLocationCoordinate2D(latitude: self.locationManager.location?.coordinate.latitude ?? 37.523844, longitude: self.locationManager.location?.coordinate.longitude ?? 126.980249)
//            setRegionAndAnnotation(center: center)
//            fetchWeatherData(type: .image, lat: center.latitude, long: center.longitude)
            
        default:
            print("DEFAULT")
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - 지도관련 설정
extension MainViewController: MKMapViewDelegate {
    
    // 이거 실행한거 함수명을 보려면 map delegate 설정이 필요
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
        locationManager.startUpdatingLocation()
    }

}

// MARK: - navigation 설정
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

