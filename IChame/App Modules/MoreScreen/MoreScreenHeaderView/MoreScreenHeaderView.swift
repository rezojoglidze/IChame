//
//  MoreScreenHeaderView.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/27/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

class MoreScreenHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var fullNameLbl: UILabel!
    
    func fill(name: String) {
        self.fullNameLbl.text = name
    }
}
