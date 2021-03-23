//
//  AppDetailDescriptionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 28.02.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailDescriptionViewController: UIViewController {
    
    private let app: ITunesApp
    
    private var appDetailDescriptionView: AppDetailDescriptionView {
        return self.view as! AppDetailDescriptionView
    }
    
//    private let dateFormatter: DateFormatter = {
//        let df = DateFormatter()
//        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        return df
//    }()
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
//    func convertDateFormat(inputDate: String) -> String {
//
//         let olDateFormatter = DateFormatter()
//         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//
//         let oldDate = olDateFormatter.date(from: inputDate)
//
//         let convertDateFormatter = DateFormatter()
//         convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
//
//         return convertDateFormatter.string(from: oldDate!)
//    }
    
    private func fillData() {
        appDetailDescriptionView.titleLabel.text = "Что нового"
        appDetailDescriptionView.versionHistoryLabel.text = "История версий"
        appDetailDescriptionView.versionNumberLabel.text = "Версия \(app.version ?? "")"
        appDetailDescriptionView.dateLabel.text = app.currentVersionReleaseDate?.convertDateString()
        appDetailDescriptionView.descriptionLabel.text = app.releaseNotes
    }
}
