//
//  ClientTableViewCell.swift
//  Fractal
//
//  Created by Pedro Cortez on 11/6/20.
//  Copyright © 2020 gamestorming. All rights reserved.
//

import UIKit

class ClientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
