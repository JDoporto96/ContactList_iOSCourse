//
//  FirstViewController.swift
//  ContactList
//
//  Created by Intekglobal01 on 1/17/24.
//

import UIKit



enum Storyboards: String {
    case Main = "Main"
    case Reports = "Reports"
}

enum Controllers: String {
    case FirstViewController = "FirstViewController"
    case SecondViewController = "SecondViewController"
}

class FirstViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, upDateDataDelegate, CustomTableViewCellDelegate{
   
    var contactManager = ContactManager.shared
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func AddButtonTapped(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: Storyboards.Main.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Controllers.SecondViewController.rawValue) as? SecondViewController {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    
    func addNewContact(contact: Contact) {
        contactManager.addContact(contact)
        tableView.reloadData()
    }
    
    func editOldContact(contact: Contact, index: Int) {
        contactManager.contactList[index] = contact
        tableView.reloadData()
    }
    
    
    func editButtonTapped(index: Int) {
        let storyboard : UIStoryboard = UIStoryboard(name: Storyboards.Main.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Controllers.SecondViewController.rawValue) as? SecondViewController {
            vc.delegate = self
            vc.index = index
            vc.contact = contactManager.contactList[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func deleteButtonTapped(index: Int) {
        showDeleteConfirmation(index: index)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contactList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        let contact = contactManager.contactList[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
        cell.firstNameLabel.text = contact.firstName
        cell.lasNameLabel.text = contact.lastName
        cell.emailLabel.text = contact.email
        
        return cell
    }
    
    
    private func showDeleteConfirmation(index: Int) {
        let alert = UIAlertController(title: "Delete Contact", message: "Are you sure you want to delete this contact?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteContact(index:index)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func deleteContact(index: Int) {
        contactManager.deleteContact(at: index)
        tableView.reloadData()
    }
    
}

