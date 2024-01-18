//
//  SecondViewController.swift
//  ContactList
//
//  Created by Intekglobal01 on 1/17/24.
//

import UIKit

protocol upDateDataDelegate {
    func addNewContact(contact: Contact)
    func editOldContact(contact: Contact, index: Int)
}

class SecondViewController: UIViewController {
    var delegate: upDateDataDelegate?
    var contacts: ContactManager?
    var index: Int?
    var contact: Contact?

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var lastNameTexfield: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact {
            firstNameTextfield.text = contact.firstName
            lastNameTexfield.text = contact.lastName
            emailTextfield.text = contact.email
        }

    }
    
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameTextfield.text,
              let lastName = lastNameTexfield.text,
              let email = emailTextfield.text,
              validateEmail(email) else {
            return
        }
        
        let newContact = Contact(firstName: firstName, lastName: lastName, email: email)
        
        if let index {
            delegate?.editOldContact(contact: newContact, index: index)
        }else {
            delegate?.addNewContact(contact: newContact)
        }
                self.navigationController?.popViewController(animated: true)
    }
    @IBAction func CancelButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
}
