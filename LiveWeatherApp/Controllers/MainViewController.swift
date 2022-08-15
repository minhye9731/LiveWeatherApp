//
//  MainViewController.swift
//  LiveWeatherApp
//
//  Created by 강민혜 on 8/15/22.
//

import UIKit

class MainViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setNavigationBar()
        self.navigationItem.title = ""

        
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
//        titleLabel.text = "실시간 현시간"
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

