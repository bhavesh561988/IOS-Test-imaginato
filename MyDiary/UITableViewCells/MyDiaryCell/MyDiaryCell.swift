//
//  MyDiaryCell.swift
//  MyDiary
//
//  Created by Hardik on 24/11/20.
//  Copyright © 2020 MyDiary. All rights reserved.
//

import UIKit

class MyDiaryCell: UITableViewCell {
    @IBOutlet weak var viewMainBG: UIView!{
        didSet{
            viewMainBG.layer.cornerRadius = 5
            viewMainBG.layer.shadowColor = UIColor.gray.cgColor
            viewMainBG.layer.shadowOffset = CGSize.zero
            viewMainBG.layer.shadowOpacity = 0.3
            viewMainBG.layer.shadowRadius = 4.0
            viewMainBG.layer.masksToBounds =  false
        }
    }
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var onEdit: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickEdit(_ sender: UIButton) {
        onEdit?()
    }
}
