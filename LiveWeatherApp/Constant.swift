//
//  Constant.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import Foundation
import UIKit

// MARK: - identifier
protocol ReusableProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - 이미지
enum ImageName: String {
    case location = "location.fill"
    case upload = "square.and.arrow.up"
    case plus = "plus"
    case setting = "gearshape.fill"
    case temperature = "thermometer"
    case wind = "wind"
    case humidity = "humidity"
}
