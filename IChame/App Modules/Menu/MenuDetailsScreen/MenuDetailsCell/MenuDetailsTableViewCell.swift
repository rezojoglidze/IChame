//
//  MenuDetailsTableViewCell.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/20/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

protocol MenuDetailsTableViewCellDelegate: class {
    func didTapActionButton(cell: MenuDetailsTableViewCell, isAdd: Bool)
}

class MenuDetailsTableViewCell: UITableViewCell {

    @IBOutlet private weak var menuItemImageView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    @IBOutlet private weak var priceLbl: UILabel!
    @IBOutlet private weak var actionBtn: UIButton! {
        didSet {
            actionBtn.setImage(UIImage(named: "add_icon"), for: .normal)
            actionBtn.setImage(UIImage(named: "remove_icon"), for: .selected)
        }
    }
    weak var delegate: MenuDetailsTableViewCellDelegate?
    var indexPath: IndexPath?

    func fill(item: MenuItem) {
        self.titleLbl.text = item.name
        self.descriptionLbl.text = item.description
        self.priceLbl.text = "\(item.price) ₾"
    }
    
    @IBAction func actionBtnTapped(_ sender: UIButton!) {
        actionBtn.isSelected.toggle()
        delegate?.didTapActionButton(cell: self, isAdd: actionBtn.isSelected)
    }
}
