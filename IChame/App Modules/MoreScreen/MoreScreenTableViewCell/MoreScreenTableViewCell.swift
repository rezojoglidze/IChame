//
//  MoreScreenTableViewCell.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/27/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

class MoreScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var actionImg: UIImageView!
    @IBOutlet weak var actionNameLabel: UILabel!
    
    func fill(_ value: Field) {
        self.actionNameLabel.text = value.title
        self.actionImg.image = UIImage(named: value.icon)
    }
}
