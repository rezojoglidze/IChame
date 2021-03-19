//
//  MenuDetailsTableViewCell.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/20/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

class MenuDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var actionBtn: UIButton! {
        didSet {
            actionBtn.setImage(UIImage(named: "add_icon"), for: .normal)
            actionBtn.setImage(UIImage(named: "remove_icon"), for: .selected)
        }
    }
    
    func fill(item: MenuItem) {
        self.titleLbl.text = item.name
        self.descriptionLbl.text = item.description
        self.priceLbl.text = "\(item.price) ₾"
    }
    
    @IBAction func actionBtnTapped(_ sender: Any) {
        actionBtn.isSelected.toggle()
    }
}
