//
//  ProfileTableViewCell.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/19/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userType: UILabel!
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
