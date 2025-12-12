//
//  AddProfileScreenViewController.swift
//  WA5_Yadav_1702
//
//  Created by Sunny Yadav on 10/9/25.
//

import UIKit
import PhotosUI

class ProfileScreenViewController: UIViewController {
    
    let profileScreen = ProfileScreenView()
    var selectedPhoneType = "Home"
    var delegate:ViewController!
    var contactToEdit: Contacts?
    var editIndex: Int?
    var pickedImage:UIImage?
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contactToEdit != nil{
            title = "Edit Contact"
            populateFields()
        } else {
            title = "Add Contact"
            profileScreen.phoneSelectType.setTitle(selectedPhoneType, for: .normal)
            profileScreen.phoneSelectType.setTitleColor(.systemBlue, for: .normal)
        }
        
        profileScreen.saveButton.addTarget(self, action: #selector(onSaveBarButtonTapped), for: .touchUpInside)
        profileScreen.profileImageButton.menu = getImageOptions()
        profileScreen.phoneSelectType.menu = getPhoneTypes()
        
        profileScreen.nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        profileScreen.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        profileScreen.phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        profileScreen.addressTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        profileScreen.cityStateTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        profileScreen.zipCodeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        if contactToEdit == nil {
            profileScreen.saveButton.isEnabled = false
            profileScreen.saveButton.alpha = 0.5
        }
        
        hideKeyboardOnTapOutside()
    }
    
    func hideKeyboardOnTapOutside(){
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func textFieldDidChange() {
        let hasContent =
            !(profileScreen.nameTextField.text ?? "").isEmpty ||
            !(profileScreen.emailTextField.text ?? "").isEmpty ||
            !(profileScreen.phoneNumberTextField.text ?? "").isEmpty ||
            !(profileScreen.addressTextField.text ?? "").isEmpty ||
            !(profileScreen.cityStateTextField.text ?? "").isEmpty ||
            !(profileScreen.zipCodeTextField.text ?? "").isEmpty
        
        profileScreen.saveButton.isEnabled = hasContent
        profileScreen.saveButton.alpha = hasContent ? 1.0 : 0.5
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func onSaveBarButtonTapped() {
        guard let name = profileScreen.nameTextField.text,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message:"Please enter your name.")
            return
        }
        
        guard let email = profileScreen.emailTextField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your email")
            return
        }
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidEmail(trimmedEmail) {
            showAlert(title: "Invalid Email", message: "Please enter a valid email address")
            return
        }
        
        if isDuplicateEmail(trimmedEmail, excludingIndex: editIndex) {
            showAlert(title: "Duplicate Email", message: "This email address is already in use by another contact.")
            return
        }
        
        guard let phoneNumber = profileScreen.phoneNumberTextField.text,
              !phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter your phone number")
            return
        }
        
        let trimmedPhone = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isValidPhoneNumber(trimmedPhone) {
            showAlert(title: "Invalid Phone", message: "Please enter a valid 10-digit phone number")
            return
        }
        
        if isDuplicatePhone(trimmedPhone, excludingIndex: editIndex) {
            showAlert(title: "Duplicate Phone", message: "This phone number is already in use by another contact")
            return
        }
        
        if let cityState = profileScreen.cityStateTextField.text, !cityState.isEmpty {
            let trimmedCityState = cityState.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let parts = trimmedCityState.split(separator: ", ").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            
            if parts.count != 2 || parts[0].isEmpty || parts[1].isEmpty {
                showAlert(title: "Invalid Format", message: "Please enter both city and state (e.g., Boston, MA)")
                return
            }
        }
        
        var zipInt: Int? = nil
        let eligibleRange = 00001...99950
        if let zipText = profileScreen.zipCodeTextField.text, !zipText.isEmpty {
            guard let zip = Int(zipText), zipText.count == 5, eligibleRange.contains(zip) else {
                showAlert(title: "Invalid ZIP", message: "Please enter a valid 5-digit ZIP code")
                return
            }
            zipInt = zip
        }
        
        let imageToSave: UIImage
        if let picked = pickedImage {
            imageToSave = picked
        } else if let existingImage = contactToEdit?.profileImage {
            imageToSave = existingImage  // Use existing image when editing
        } else {
            imageToSave = UIImage(systemName: "person.crop.circle")!  // Default only for new contacts
        }
        
        let contact = Contacts(name: name, email: email, phoneNumber: phoneNumber, phoneType: selectedPhoneType, address: profileScreen.addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), cityState: profileScreen.cityStateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), zipCode: zipInt, image: imageToSave)
        
        if let index = editIndex {
            delegate.delegateOnEditContact(contact: contact, at: index)
        } else {
            delegate.delegateOnSaveContact(contact: contact)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func populateFields() {
        guard let contact = contactToEdit else { return }
        
        profileScreen.nameTextField.text = contact.name
        profileScreen.emailTextField.text = contact.email
        profileScreen.phoneNumberTextField.text = contact.phoneNumber
        profileScreen.addressTextField.text = contact.address
        profileScreen.cityStateTextField.text = contact.cityState
        
        if let zipCode = contact.zipCode {
            profileScreen.zipCodeTextField.text = String(zipCode)
        }
        
        if let profileImage = contact.profileImage {
            print(profileImage)
            self.pickedImage = profileImage
            profileScreen.profileImageButton.setImage(self.pickedImage, for: .normal)
        }
        
        if let phoneType = contact.phoneType {
            selectedPhoneType = phoneType
            profileScreen.phoneSelectType.setTitle(phoneType, for: .normal)
        }
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
    
    func getPhoneTypes() -> UIMenu {
        var menuItems = [UIAction]()
                
        for type in Utilities.types{
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedPhoneType = type
                                self.profileScreen.phoneSelectType.setTitle(self.selectedPhoneType, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select type", children: menuItems)
    }
    
    func getImageOptions() -> UIMenu {
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    func isDuplicateEmail(_ email: String, excludingIndex: Int?) -> Bool {
        for (index, contact) in delegate.contacts.enumerated() {
            if let editIdx = excludingIndex, index == editIdx {
                continue
            }
            if contact.email?.lowercased() == email.lowercased() {
                return true
            }
        }
        return false
    }

    func isDuplicatePhone(_ phone: String, excludingIndex: Int?) -> Bool {
        let normalizedInput = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        for (index, contact) in delegate.contacts.enumerated() {
            if let editIdx = excludingIndex, index == editIdx {
                continue
            }
            if let existingPhone = contact.phoneNumber {
                let normalizedExisting = existingPhone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if normalizedExisting == normalizedInput {
                    return true
                }
            }
        }
        return false
    }
}


//MARK: adopting required protocols for UIImagePicker...
extension ProfileScreenViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.profileScreen.profileImageButton.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}

extension ProfileScreenViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)

        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.profileScreen.profileImageButton.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}
