//
//  ViewController.swift
//  Working with APIs
//
//  Created by Sunny Yadav on 10/22/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    var contactNames = [String]()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts API Testing"
        
        mainScreen.tableViewContacts.dataSource = self
        mainScreen.tableViewContacts.delegate = self
        mainScreen.tableViewContacts.separatorStyle = .none
        
        mainScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleContactDeleted),
            name: .deleteContact,
            object: nil
        )
    
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleContactEdited),
            name: .editContact,
            object: nil
        )
        
        getAllContacts()
        hideKeyboardOnTapOutside()
    }
    
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func handleContactDeleted() {
        getAllContacts()
    }
    
    @objc func handleContactEdited() {
        getAllContacts()
    }
    
    @objc func onButtonAddTapped(){
        // Validate Name
        guard let name = mainScreen.textFieldAddName.text,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter a name.")
            return
        }
        
        // Validate Email
        guard let email = mainScreen.textFieldAddEmail.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter an email.")
            return
        }
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(trimmedEmail) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        // Validate Phone
        guard let phoneText = mainScreen.textFieldAddPhone.text,
              !phoneText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter a phone number.")
            return
        }
        
        let trimmedPhone = phoneText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidPhoneNumber(trimmedPhone) {
            showAlert(title: "Invalid Phone", message: "Please enter a valid 10-digit phone number")
            return
        }
        
        guard let phoneInt = Int(trimmedPhone) else {
                showAlert(title: "Invalid Phone", message: "Phone number must be numeric")
                return
            }
        
        let newContact = Contact(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            email: trimmedEmail,
            phone: phoneInt
        )
        
        addANewContact(contact: newContact)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPhoneNumber(_ phone: String) -> Bool {
           let phoneDigits = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
           return phoneDigits.count == 10
       }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func addANewContact(contact: Contact){
        if let url = URL(string: APIConfigs.baseURL+"add"){
            
            AF.request(url, method:.post, parameters:
                        [
                            "name": contact.name,
                            "email": contact.email,
                            "phone": contact.phone
                        ])
                .responseString(completionHandler: { response in
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(let data):
                        
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                case 200...299:
                                self.getAllContacts()
                                self.clearAddViewFields()
                                    break
                        
                                case 400...499:
                                    print(data)
                                    self.showAlert(title: "Error", message: "Failed to add contact. Please check your input.")
                                    break
                        
                                default:
                                    print(data)
                                    self.showAlert(title: "Server Error", message: "Something went wrong. Please try again later.")
                                    break
                            }
                        }
                        break
                        
                    case .failure(let error):
                        print(error)
                        self.showAlert(title: "Network Error", message: "Unable to connect to server. Please check your connection.")
                        break
                    }
                })
        }else{
            showAlert(title: "Error", message: "Invalid URL configuration.")
        }
    }
    
    func clearAddViewFields(){
        mainScreen.textFieldAddName.text = ""
        mainScreen.textFieldAddEmail.text = ""
        mainScreen.textFieldAddPhone.text = ""
    }
    
    func getAllContacts(){
        if let url = URL(string: APIConfigs.baseURL + "getall"){
            AF.request(url, method: .get).responseString(completionHandler: { response in
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                                let names = data.components(separatedBy: "\n")
                                self.contactNames = names
                                self.contactNames.removeLast()
                                self.mainScreen.tableViewContacts.reloadData()
                                print(self.contactNames)
                                break
                    
                            case 400...499:
                                print(data)
                                self.showAlert(title: "Error", message: "Failed to load contacts.")
                                break
                    
                            default:
                                print(data)
                                self.showAlert(title: "Server Error", message: "Unable to load contacts. Please try again.")
                                break
                        }
                    }
                    break

                case .failure(let error):
                    print(error)
                    self.showAlert(title: "Network Error", message: "Unable to connect to server. Please check your connection.")
                    break
                }
            })
        }
    }
    
    func getContactDetails(name: String){
        if let url = URL(string: APIConfigs.baseURL+"details"){
            AF.request(url, method:.get,
                       parameters: ["name":name],
                       encoding: URLEncoding.queryString)
                .responseString(completionHandler: { response in
                
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                        case 200...299:
                            self.parseAndShowContactDetails(data: data)
                            break
                        case 400...499:
                            print(data)
                            self.showAlert(title: "Error", message: "Contact not found.")
                            break
                        default:
                            print(data)
                            self.showAlert(title: "Server Error", message: "Unable to load contact details. Please try again.")
                            break
                        }
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                    self.showAlert(title: "Network Error", message: "Unable to connect to server. Please check your connection.")
                    break
                }
            })
        }
    }

    func parseAndShowContactDetails(data: String) {
        let parts = data.components(separatedBy: ",")
        
        if parts.count >= 3 {
            let name = parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let email = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let phone = Int(parts[2].trimmingCharacters(in: .whitespacesAndNewlines)) {
                let contact = Contact(name: name, email: email, phone: phone)
                
                let detailsVC = ContactDetailsViewController()
                detailsVC.contact = contact
                navigationController?.pushViewController(detailsVC, animated: true)
            }
        }
    }
        
    }

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "names", for: indexPath) as! ContactsTableView
        cell.labelName.text = contactNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getContactDetails(name: self.contactNames[indexPath.row])
    }
}
