//
//  PlayListTableViewCell.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class PlayListTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImgView: UIImageView!
    
    @IBOutlet weak var albumTitleLbl: UILabel!
    
    @IBOutlet weak var likedBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutCell(
        albumImg: String,
        albumTitle: String,
        isLiked: Bool
    ) {
        
        
        
        
    }

}
