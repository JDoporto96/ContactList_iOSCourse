//
//  TableViewCell.swift
//  ContactList
//
//  Created by Intekglobal01 on 1/17/24.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func editButtonTapped(index: Int)
    
    func deleteButtonTapped(index: Int)
}



class CustomTableViewCell: UITableViewCell{
    
    weak var delegate: CustomTableViewCellDelegate?
    var index: Int?
    
    @IBOutlet weak var lasNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func EditButtonTapped(_ sender: UIButton) {
        delegate?.editButtonTapped(index: index!)
    }
    
    
    @IBAction func DeleteButtonTapped(_ sender: UIButton) {
        delegate?.deleteButtonTapped(index: index!)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
