//
//  MenuScreenCell.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

class MenuScreenCell: UITableViewCell {

    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var onePointHeightBlackLine: UIView!
    
    func fill(img: UIImage?, title: String) {
        self.titleLbl.text = title
        self.menuImg.image = img
    }
}
