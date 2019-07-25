//
//  ReportsTableViewCell.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/24/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class ReportsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageViewRounded!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loader.hidesWhenStopped = true
        loader.startAnimating()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
