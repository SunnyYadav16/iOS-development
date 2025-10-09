//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Sunny Yadav on 9/18/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    @IBOutlet var historyLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var reComputeButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addButton.addTarget(self, action: #selector(onAddButtonClick), for: .touchUpInside)
        
        subtractButton.addTarget(self, action: #selector(onSubtractButtonClick), for: .touchUpInside)
        
        multiplyButton.addTarget(self, action: #selector(onMultiplyButtonClick), for: .touchUpInside)
        
        divideButton.addTarget(self, action: #selector(onDivideButtonClick), for: .touchUpInside)
        
        clearButton.addTarget(self, action: #selector(onClearButtonClick), for: .touchUpInside)
        
        reComputeButton.addTarget(self, action: #selector(onReComputeButtonClick), for: .touchUpInside)
    }
    
    @objc func onAddButtonClick() {
        guard let (firstNumber, secondNumber) = getNumbers() else { return }
        let result = firstNumber + secondNumber
        resultLabel.text = String(format: "%.2f", result)

        historyLabel.text = "\(firstNumber) + \(secondNumber) = \(String(format: "%.2f", result))"
    }
    
    @objc func onSubtractButtonClick() {
        guard let (firstNumber, secondNumber) = getNumbers() else { return }
        let result = firstNumber - secondNumber
        resultLabel.text = String(format: "%.2f", result)
        
        historyLabel.text = "\(firstNumber) - \(secondNumber) = \(String(format: "%.2f", result))"
    }
    
    @objc func onMultiplyButtonClick() {
        guard let (firstNumber, secondNumber) = getNumbers() else { return }
        let result = firstNumber * secondNumber
        resultLabel.text = String(format: "%.2f", result)
        
        historyLabel.text = "\(firstNumber) * \(secondNumber) = \(String(format: "%.2f", result))"
    }
    
    @objc func onDivideButtonClick() {
        guard let (firstNumber, secondNumber) = getNumbers() else { return }
        if secondNumber == 0 {
            showErrorAlert(message: "Cannot divide by zero.")
            return
        }
        let result = firstNumber / secondNumber
        resultLabel.text = String(format: "%.2f", result)
        
        historyLabel.text = "\(firstNumber) / \(secondNumber) = \(String(format: "%.2f", result))"
    }
    
    @objc func onClearButtonClick() {
        if (firstNumberTextField.text ?? "").isEmpty && (secondNumberTextField.text ?? "").isEmpty {
            showErrorAlert(message: "There is no text to clear.")
            return
        }
        
        firstNumberTextField.text = nil
        secondNumberTextField.text = nil
        resultLabel.text = "Result"
    }
    
    @objc func onReComputeButtonClick() {
        if historyLabel.text == "History: None" {
            showErrorAlert(message: "No prior computation!")
            return
        }
        
        if let history = historyLabel.text,
           let lastResult = history.components(separatedBy: " = ").last {
            firstNumberTextField.text = lastResult
        }
        
        secondNumberTextField.text = nil
        resultLabel.text = "Result"
    }
    
    func getNumbers() -> (Double, Double)? {
        let firstText = firstNumberTextField.text ?? ""
        let secondText = secondNumberTextField.text ?? ""
        return validateNumbers(textOne: firstText, textTwo: secondText)
    }
    
    func validateNumbers(textOne: String, textTwo: String) -> (Double, Double)? {
        if textOne.isEmpty || textTwo.isEmpty {
            showErrorAlert(message: "Error! The numbers cannot be empty!")
            return nil
        }
        
        guard let firstNumber = Double(textOne) else {
            showErrorAlert(message: "First value is not a valid number.")
            return nil
        }
        
        guard let secondNumber = Double(textTwo) else {
            showErrorAlert(message: "Second value is not a valid number.")
            return nil
        }
        
        return (firstNumber, secondNumber)
    }
    
    func showErrorAlert(message: String){
        let alert = UIAlertController(
            title: "Error!", message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
