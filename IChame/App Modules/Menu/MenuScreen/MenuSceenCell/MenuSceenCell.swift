//
//  MenuSceenCell.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/19/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit

class MenuSceenCell: UITableViewCell {

  @IBOutlet weak var menuImg: UIImageView!
  @IBOutlet weak var menuTitleLbl: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func fill(imgUrl: String, title: String) {
    self.menuTitleLbl.text = title
  }
}
