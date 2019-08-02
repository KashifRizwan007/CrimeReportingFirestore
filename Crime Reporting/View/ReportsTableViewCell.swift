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
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var statusBtn: ButtonDesign!
    
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
