//
//  MenuScreenCell.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

class OrderScreenTableViewCell: UITableViewCell {

    @IBOutlet private weak var menuImg: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var circleView: UIView!
    
    func fill(order: Order, index: Int) {
        self.titleLbl.text = "შეკვეთა №\(index)"
        self.menuImg.image = UIImage(named: "coldDishes_icon")
        self.statusLbl.text = order.status?.title
        self.statusLbl.textColor =  order.status?.color
        self.circleView.backgroundColor = order.status?.color
    }
}
