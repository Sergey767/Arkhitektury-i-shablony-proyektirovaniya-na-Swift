//
//  SettingsViewController.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 03.12.2020.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var questionModeControl: UISegmentedControl!
    @IBOutlet weak var returnMainScreenButton: UIButton!
    
    @IBAction func chooseModeControl(sender: UISegmentedControl) {
        GameSingleton.shared.selectedQuestionMode = sender.selectedSegmentIndex
    }
    
    private var selectedQuestionMode: QuestionMode {
        switch questionModeControl.selectedSegmentIndex {
        case 0:
            return .consistently
        case 1:
            return .randomly
        default:
            return .consistently
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionModeControl.selectedSegmentIndex = GameSingleton.shared.selectedQuestionMode
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender senser: Any?) {
        switch segue.identifier {
        case "to_mainVC":
            if let destination = segue.destination as? MainViewController {
                destination.questionMode = selectedQuestionMode
            }
        default:
            break
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.destination is MainViewController
//        {
//            let vc = segue.destination as? MainViewController
//            vc?.questionMode = selectedQuestionMode
//        }
//    }
}
