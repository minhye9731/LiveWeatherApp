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
    func fetchWeatherAPI(type: Endpoint, latitude: Double, longitude: Double, completionHandler: @escaping(JSON) -> ()) {
        
        let url = type.requestURL + "lat=\(latitude)&lon=\(longitude)&appid=\(APIKey.OPENWEATHER)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
}








