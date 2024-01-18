//
//  ContactManager.swift
//  ContactList
//
//  Created by Intekglobal01 on 1/17/24.
//

import Foundation

class ContactManager {
    
    static let shared = ContactManager()
    
    var contactList: [Contact] = []
    
    private init() {}
    
    
    func addContact(_ contact: Contact) {
        contactList.append(contact)
    }
    
    // Delete a contact
    func deleteContact(at index: Int) {
        contactList.remove(at: index)

    }

}
