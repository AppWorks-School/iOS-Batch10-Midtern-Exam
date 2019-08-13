//
//  PlayListView.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/13.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class PlayListView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerImgView.kf.setImage(with: URL(string: "https://i.kfs.io/playlist/global/26541395v266/cropresize/600x600.jpg"))
        
        headerImgView.frame.size.height = UIScreen.main.bounds.width
    }
    
    
}
