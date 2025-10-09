//
//  ShowViewController.swift
//  NavigationDemo
//
//  Created by Sunny Yadav on 9/22/25.
//

import UIKit

class ShowViewController: UIViewController {
    var messageFromFirstScreen:String? = "No message received!" //First screen can set this variable...
    var delegate: ViewController!
    let moods: [String] = ["Happy", "Meh", "Sad"] // moods for moodPicker...
    var selectedMood = "Happy"
    
    var labelMessage: UILabel!
    var labelMoodInstructions: UILabel!
    var moodPicker: UIPickerView!
    var buttonSendMood: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting the view background to white...
        view.backgroundColor = .white
        
        setupLabelMessage()
        setupLabelMoodInstructions()
        setupMoodPicker()
        setupButtonSendMood()
        
        initConstraints()
        
        buttonSendMood.addTarget(self, action: #selector(onSendMoodButtonTapped), for: .touchUpInside)
    }
    
    // MARK: on send button tapped...
    @objc func onSendMoodButtonTapped(){
        delegate.delegateButtonSendMood(mood: selectedMood)
        navigationController?.popViewController(animated: true)
    }

    func setupLabelMessage(){
        labelMessage = UILabel()
        labelMessage.textColor = .systemBlue
        labelMessage.text = messageFromFirstScreen
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelMessage)
    }
    
    // setting up labelMoodInstructions...
    func setupLabelMoodInstructions(){
        labelMoodInstructions = UILabel()
        labelMoodInstructions.text = "How are you feeling today?"
        labelMoodInstructions.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelMoodInstructions)
    }
    
    // setting up mood picker...
    func setupMoodPicker(){
        moodPicker = UIPickerView()
        moodPicker.isUserInteractionEnabled = true
        moodPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moodPicker)
        
        //patching the delegate and data source...
        moodPicker.delegate = self
        moodPicker.dataSource = self
    }
    
    // setting up buttonSendMood...
    func setupButtonSendMood(){
        buttonSendMood = UIButton(type: .system)
        buttonSendMood.setTitle("Send Mood back!", for: .normal)
        buttonSendMood.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonSendMood)
    }
    
    // MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            //labelMessage constraints...
            labelMessage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            labelMessage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            //labelMoodInstructions constraints...
            labelMoodInstructions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            labelMoodInstructions.topAnchor.constraint(equalTo: labelMessage.bottomAnchor, constant: 16),
            
            //mood picker constraints...
            moodPicker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            moodPicker.topAnchor.constraint(equalTo: labelMoodInstructions.bottomAnchor, constant: 16),
            
            //buttonSendMood constraints...
            buttonSendMood.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonSendMood.topAnchor.constraint(equalTo: moodPicker.bottomAnchor, constant: 16),
        ])
    }
}

// MARK: Conforming to required PickerView protocols...
extension ShowViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    //returns the number of columns/components in the Picker View...
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //returns the number of rows in the current component...
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moods.count
    }
    
    //set the title of currently picked row...
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // on change selection, update selectedMood...
        selectedMood = moods[row]
        return moods[row]
    }
}
