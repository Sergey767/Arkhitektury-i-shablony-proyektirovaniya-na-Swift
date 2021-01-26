//
//  MainViewController.swift
//  XO-game
//
//  Created by Сергей Горячев on 15.01.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

public var pOrC = 0

class MainViewController: UIViewController {
    
    @IBAction func playerVsComputerButtonPressed(_ sender: UIButton) {
        
        pOrC = 1
        performSegue(withIdentifier: "playTheGame", sender: self)
    }
    
    @IBAction func playerVsPlayerButtonPressed(_ sender: UIButton) {
        pOrC = 2
        performSegue(withIdentifier: "playTheGame", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
