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
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerImgView.kf.setImage(with: URL(string: "https://i.kfs.io/playlist/global/26541395v266/cropresize/600x600.jpg"))
        
        headerImgView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        
        blurView.frame = headerImgView.frame
        
        blurView.alpha = 0.0
        
        tableView.contentInset = UIEdgeInsets(top: UIScreen.main.bounds.width, left: 0, bottom: 0, right: 0)
        
        tableView.contentOffset = CGPoint(x: 0, y: UIScreen.main.bounds.width)
    }
    
    func updateHeaderViewLayout(y: CGFloat, alpha: CGFloat, width: CGFloat = UIScreen.main.bounds.width) {
        
        headerImgView.frame.origin.y = y
        
        headerImgView.alpha = 1 - alpha
        
        blurView.frame.origin.y = y
        
        blurView.alpha = alpha
    
        headerImgView.frame.size.height = width
    }
}
