//
//  UserTableViewCell.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    func setup(_ viewModel: UserCellViewModel) {
        mainLabel.text = viewModel.mainText
        secondaryLabel.text = viewModel.secondaryText
    }
}
