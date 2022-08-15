//
//  WeatherAPIManager.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    
    private init() { }
    
    // 실시간 현위치 위도&경도 받아오기
    
    
    // 날씨 데이터 받아오기
    func fetchWeatherAPI(type: Endpoint, latitude: Double, longitude: Double, completionHandler: @escaping(WeatherModel) -> ()) {
        
        let url = type.requestURL + "lat=\(latitude)&lon=\(longitude)&appid=\(APIKey.OPENWEATHER)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                let iconCode = json["weather"][0]["icon"].stringValue
                let mainWeather = json["weather"][0]["main"].stringValue
                let descriptionWeather = json["weather"][0]["description"].stringValue
                let temp = json["main"]["temp"].doubleValue
                let tempfeel = json["main"]["feels_like"].doubleValue
                let tempmin = json["main"]["temp_min"].doubleValue
                let tempmax = json["main"]["temp_max"].doubleValue
                let hum = json["main"]["humidity"].intValue
                
                let windspeed = json["wind"]["speed"].doubleValue
                let winddeg = json["wind"]["deg"].intValue
                
                let cnt = json["sys"]["country"].stringValue
                let city = json["name"].stringValue
                
                let weatherData = WeatherModel(icon: iconCode, weather: mainWeather, weatherDetail: descriptionWeather, temperature: temp, temperatureFeel: tempfeel, temperatureMin: tempmin, temperatureMax: tempmax, humidity: hum, windSpeed: windspeed, windDeg: winddeg, country: cnt, cityname: city)
                
                completionHandler(weatherData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
}








