//
//  Endpoint.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import Foundation

enum Endpoint {
    
    case data
    case image
    
    var requestURL: String {
        switch self {
        case .data:
            return URL.makeEndPointString("weather?")
        case .image:
            return "https://openweathermap.org/img/wn/"
        }
    }
}
