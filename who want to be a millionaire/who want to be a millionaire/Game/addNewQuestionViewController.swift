//
//  addNewQuestionViewController.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 14.12.2020.
//

import UIKit

class addNewQuestionViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var enterQuestionLabel: UILabel!
    @IBOutlet weak var enterNewQuestionTextField: UITextField!
    @IBOutlet weak var enterAnswerATextField: UITextField!
    @IBOutlet weak var enterAnswerBTextField: UITextField!
    @IBOutlet weak var enterAnswerCTextField: UITextField!
    @IBOutlet weak var enterAnswerDTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var AddNewQuestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is GameViewController
        {
            let destinationGameVC = segue.destination as? GameViewController
            destinationGameVC?.currentQuestion?.question = enterNewQuestionTextField.text ?? ""
            destinationGameVC?.currentQuestion?.answers[0] = enterAnswerATextField.text ?? ""
            destinationGameVC?.currentQuestion?.answers[1] = enterAnswerBTextField.text ?? ""
            destinationGameVC?.currentQuestion?.answers[2] = enterAnswerCTextField.text ?? ""
            destinationGameVC?.currentQuestion?.answers[3] = enterAnswerDTextField.text ?? ""
            destinationGameVC?.currentQuestion?.correctAnswer = Int(correctAnswerTextField.text!)!
        }
    }
}
