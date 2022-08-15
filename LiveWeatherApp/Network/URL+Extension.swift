//
//  URL+Extension.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import Foundation

import Foundation

extension URL {
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    // 연산 프로퍼티로도 활용 가능
    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }

}
